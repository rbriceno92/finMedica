import 'package:equatable/equatable.dart';

class ConfidentialityState extends Equatable {
  final bool isPrivate;

  const ConfidentialityState({this.isPrivate = false});

  @override
  List<Object?> get props => [isPrivate];

  ConfidentialityState copyWith({bool? isPrivate}) {
    return ConfidentialityState(isPrivate: isPrivate ?? this.isPrivate);
  }
}
