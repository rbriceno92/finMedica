import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_us_data_request.g.dart';

@JsonSerializable()
class ContactUsDataRequest extends Equatable {
  final String title;
  final String body;
  final String? email;

  const ContactUsDataRequest(
      {required this.title, required this.body, required this.email});

  factory ContactUsDataRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactUsDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsDataRequestToJson(this);

  @override
  List<Object?> get props => [title, body, email];
}
