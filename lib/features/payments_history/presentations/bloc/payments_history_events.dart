import 'package:app/features/payments_history/presentations/bloc/payments_history_state.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentsHistoryEvent extends Equatable {
  const PaymentsHistoryEvent();
}

class DisposeLoading extends PaymentsHistoryEvent {
  @override
  List<Object?> get props => [];
}

class FilterBy extends PaymentsHistoryEvent {
  final FilterSelect filter;
  final String? page;
  const FilterBy({required this.filter, this.page});

  @override
  List<Object?> get props => [filter, page];
}
