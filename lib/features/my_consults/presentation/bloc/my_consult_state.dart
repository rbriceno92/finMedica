import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/chips.dart';

class MyConsultState extends Equatable {
  final bool isLoading;
  final List<Consult>? consults;
  final List? consultsFiltered;
  final String message;
  final List<ChipFilter> chips;

  const MyConsultState(
      {this.isLoading = false,
      this.consults = const [],
      this.consultsFiltered,
      this.message = '',
      this.chips = const <ChipFilter>[]});

  @override
  List<Object?> get props =>
      [isLoading, consults, consultsFiltered, message, chips];

  MyConsultState copyWith(
      {bool? isLoading,
      List<Consult>? consults,
      List? consultsFiltered,
      String? message,
      List<ChipFilter>? chips}) {
    return MyConsultState(
        isLoading: isLoading ?? false,
        consults: consults ?? this.consults,
        consultsFiltered: consultsFiltered ?? this.consultsFiltered,
        message: message ?? this.message,
        chips: chips ?? this.chips);
  }
}
