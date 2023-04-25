import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/features/store/domain/use_case/store_fetch_data_use_case.dart';
import 'package:app/features/store/presentation/bloc/store_events.dart';
import 'package:app/features/store/presentation/bloc/store_state.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/message_model.dart';
import 'package:app/util/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreFetchDataUseCase storeFetchDataUseCase;
  StoreBloc({required this.storeFetchDataUseCase})
      : super(const StoreState(products: [])) {
    on<DisposeLoading>(_onDisposeLoading);
    on<FetchData>(_onFetchData);
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<StoreState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose));

  void _onFetchData(FetchData event, Emitter<StoreState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var result = await storeFetchDataUseCase.call(ParametroVacio());
    List<CartItem> products = result.fold(
      (l) {
        if (l is ServerFailure) {
          event.onError(l.modelServer.isSimple()
              ? (l.modelServer.message as String)
              : (l.modelServer.message as List<MessageModel>?)!
                  .map((e) => e.message)
                  .join(', '));
        } else {
          event.onError((l as ErrorMessage).message);
        }
        return [];
      },
      (r) {
        return r.products.map((e) => e.toEntity()).toList();
      },
    );

    if (products.isNotEmpty) {
      products.sort(((a, b) => a.quantity.compareTo(b.quantity)));
    }
    if (products.length % 2 == 1) {
      products.add(const CartItem(amount: 0, quantity: 0, id: ''));
    }

    emit(state.copyWith(products: products, loading: LoadingState.close));
  }
}
