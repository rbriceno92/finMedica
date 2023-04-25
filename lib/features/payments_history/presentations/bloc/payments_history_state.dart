import 'package:app/features/payments_history/domain/entities/payment_record.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

enum FilterSelect {
  all,
  succeeded,
  incomplete,
  failed,
}

class PaymentsHistoryState extends Equatable {
  final List<PaymentRecord>? items;
  final FilterSelect filterSelect;
  final LoadingState loading;
  final String? nextPage;
  final String errorMessage;

  const PaymentsHistoryState(
      {this.items,
      this.nextPage,
      this.errorMessage = '',
      this.filterSelect = FilterSelect.all,
      this.loading = LoadingState.dispose});

  PaymentsHistoryState copyWith(
          {List<PaymentRecord>? items,
          dynamic page,
          String? errorMessage,
          FilterSelect? filterSelect,
          LoadingState? loading}) =>
      PaymentsHistoryState(
          nextPage: page,
          errorMessage: errorMessage ?? this.errorMessage,
          items: items ?? this.items,
          filterSelect: filterSelect ?? this.filterSelect,
          loading: loading ?? this.loading);

  @override
  List<Object?> get props =>
      [items, filterSelect, loading, nextPage, errorMessage];
}
