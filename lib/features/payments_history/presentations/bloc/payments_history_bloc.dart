import 'package:app/features/payments_history/domain/entities/payment_record.dart';
import 'package:app/features/payments_history/domain/use_case/payments_history_fetch_data.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/failure.dart';
import 'payments_history_events.dart';
import 'payments_history_state.dart';

class PaymentsHistoryBloc
    extends Bloc<PaymentsHistoryEvent, PaymentsHistoryState> {
  PaymentHistoryFetchDataUseCase paymentHistoryFetchDataUseCase;
  PaymentsHistoryBloc({required this.paymentHistoryFetchDataUseCase})
      : super(const PaymentsHistoryState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<FilterBy>(_onFilterBy);
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<PaymentsHistoryState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose));

  void _onFilterBy(FilterBy event, Emitter<PaymentsHistoryState> emit) async {
    emit(state.copyWith(
      loading: LoadingState.show,
      filterSelect: event.filter,
    ));
    var filtre = event.filter.name != '' && event.filter.name != 'all'
        ? '?status=${event.filter.name}&limit=15'
        : '?limit=15';
    var query = event.page != null ? '$filtre&page=${event.page}' : filtre;
    var result = await paymentHistoryFetchDataUseCase.call(query);
    List<PaymentRecord> list = event.page != null ? state.items! : [];
    result.fold(
      (l) {
        emit(state.copyWith(
            loading: LoadingState.close,
            errorMessage: getMessage(l),
            items: []));
      },
      (r) {
        list.addAll(r.userPaymentHistory.map((e) => e.toEntity()));
        emit(state.copyWith(
            loading: LoadingState.close, items: list, page: r.nextPage));
      },
    );
  }

  String getMessage(ErrorGeneral l) {
    if (l is ServerFailure) {
      if (l.modelServer.isSimple()) {
        return l.modelServer.message ?? '';
      } else {
        return l.modelServer.message?.first.message ?? '';
      }
    }
    if (l is ErrorMessage) {
      return l.message;
    }
    return ERROR_MESSAGE;
  }
}
