import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class StoreState extends Equatable {
  final LoadingState loading;
  final List<CartItem> products;

  const StoreState(
      {this.loading = LoadingState.dispose, required this.products});

  StoreState copyWith({LoadingState? loading, List<CartItem>? products}) =>
      StoreState(
          loading: loading ?? this.loading,
          products: products ?? this.products);

  @override
  List<Object?> get props => [loading, products];
}
