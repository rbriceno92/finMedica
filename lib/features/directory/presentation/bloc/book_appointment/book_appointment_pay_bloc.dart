import 'package:app/features/directory/data/models/book_appointment_response.dart';
import 'package:app/features/directory/domain/use_cases/book_appointment_use_case.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_pay_events.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_pay_state.dart';
import 'package:app/features/payments/data/models/create_payment_request.dart';
import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/features/store/domain/use_case/payment_create_use_case.dart';
import 'package:app/features/store/domain/use_case/store_fetch_data_use_case.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookAppointmentPayBloc
    extends Bloc<BookAppointmentPayEvent, BookAppointmentPayState> {
  final StoreFetchDataUseCase storeFetchDataUseCase;
  final CreatePaymentIntentUseCase createPaymentIntentUseCase;
  final UserPreferenceDao userDao;
  final BookAppointmentUseCase bookAppointmentUseCase;

  BookAppointmentPayBloc({
    required this.storeFetchDataUseCase,
    required this.createPaymentIntentUseCase,
    required this.userDao,
    required this.bookAppointmentUseCase,
  }) : super(const BookAppointmentPayState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<FetchProducts>(_onFetchData);
    on<PayItem>(_onPayItem);
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<BookAppointmentPayState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose, errorMessage: ''));

  void _onFetchData(
      FetchProducts event, Emitter<BookAppointmentPayState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var result = await storeFetchDataUseCase.call(ParametroVacio());
    List<dynamic> status = result.fold(
      (l) {
        return ['error', getMessage(l)];
      },
      (r) {
        return ['', r.products.map((e) => e.toEntity()).toList()];
      },
    );

    if ((status.first as String).isNotEmpty) {
      emit(state.copyWith(
          errorMessage: status.last, loading: LoadingState.close));
    } else {
      (status.last as List<CartItem>)
          .sort(((a, b) => a.quantity.compareTo(b.quantity)));

      emit(
          state.copyWith(item: status.last.first, loading: LoadingState.close));
    }
  }

  void _onPayItem(PayItem event, Emitter<BookAppointmentPayState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var userDaoResult = await userDao.getUser();
    var user = userDaoResult.fold((error) => null, (user) => user);

    if (user == null) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: ERROR_MESSAGE));
      return;
    }

    final responseBookA = await bookAppointmentUseCase.call(event.params);
    var results =
        responseBookA.fold((l) => ['error', getMessage(l)], (r) => ['', r]);

    if ((results.first as String).isNotEmpty) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: results.last as String));
      return;
    }

    var resultcreatePayment = await createPaymentIntentUseCase.call(
        CreatePaymentRequest(
            email: user.email ?? '',
            productId: state.item.id,
            consultAlephooId: (results.last as BookAppointmentResponse)
                .alephooResponse
                .data
                .id));

    List<String> status = resultcreatePayment.fold(
      (l) {
        return ['Error', getMessage(l)];
      },
      (r) {
        return ['', r.clientSecret, r.ephemeralKey];
      },
    );

    if (status.first.isNotEmpty) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: status.last));
      return;
    }
    emit(state.copyWith(
        customerId: user.stripeCustomerId,
        paymentIntentClientSecret: status[1],
        customerEphemeralKeySecret: status[2],
        loading: LoadingState.close));
  }

  String getMessage(ErrorGeneral l) {
    if (l is ServerFailure) {
      if (l.modelServer.isSimple()) {
        return l.modelServer.message ?? '';
      } else {
        return l.modelServer.message?.map((e) => (e.message ?? '')).join(', ');
      }
    }
    if (l is ErrorMessage) {
      return l.message;
    }
    return ERROR_MESSAGE;
  }
}
