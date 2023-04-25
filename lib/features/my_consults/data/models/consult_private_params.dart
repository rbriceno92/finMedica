import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'consult_private_params.g.dart';

@JsonSerializable()
class ConsultPrivateParams extends Equatable {
  final String consultId;
  final bool flag;

  const ConsultPrivateParams({required this.consultId, required this.flag});

  @override
  List<Object?> get props => [consultId, flag];

  factory ConsultPrivateParams.fromJson(Map<String, dynamic> json) =>
      _$ConsultPrivateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultPrivateParamsToJson(this);
}
