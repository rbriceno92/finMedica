// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'consult_type.dart';

class ChipFilter extends Equatable {
  final String name;
  bool selected;
  final ConsultType consultType;
  ChipFilter(
      {required this.name, required this.selected, required this.consultType});

  @override
  List<Object?> get props => [name, selected, consultType];
}
