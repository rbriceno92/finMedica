import 'package:app/util/models/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_model_server.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorModelServer extends Equatable {
  final String? error;
  final dynamic message;
  final int? statusCode;
  final String? path;
  final String? method;
  final String? timeStamp;

  const ErrorModelServer(this.error, this.message, this.statusCode, this.path,
      this.method, this.timeStamp);

  factory ErrorModelServer.fromJson(Map<String, dynamic> json) {
    var tem = _$ErrorModelServerFromJson(json);
    return ErrorModelServer(
        tem.error,
        tem.isSimple()
            ? tem.message
            : (tem.message as List)
                .map((e) => MessageModel.fromJson(e))
                .toList(),
        tem.statusCode,
        tem.path,
        tem.path,
        tem.timeStamp);
  }

  Map<String, dynamic> toJson() => _$ErrorModelServerToJson(this);

  @override
  List<Object?> get props =>
      [error, message, statusCode, path, method, timeStamp];

  static ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }

  bool isSimple() {
    return message is String;
  }
}
