import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_response.g.dart';

@JsonSerializable()
class BookAppointmentResponse extends Equatable {
  @JsonKey(name: 'alephoo_response')
  final AlephooResponse alephooResponse;

  const BookAppointmentResponse({
    required this.alephooResponse,
  });

  @override
  List<Object?> get props => [alephooResponse];

  factory BookAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentResponseToJson(this);
}

@JsonSerializable()
class AlephooResponse extends Equatable {
  final AlephooResponseData data;
  final dynamic included;
  final AlephooResponseLink links;
  final AlephooResponseMeta meta;

  const AlephooResponse({
    required this.data,
    required this.included,
    required this.links,
    required this.meta,
  });

  @override
  List<Object?> get props => [data, links, included, meta];

  factory AlephooResponse.fromJson(Map<String, dynamic> json) =>
      _$AlephooResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlephooResponseToJson(this);
}

@JsonSerializable()
class AlephooResponseData extends Equatable {
  final String type;
  final int id;
  final dynamic attributes;
  final dynamic relationships;

  const AlephooResponseData({
    required this.type,
    required this.id,
    required this.attributes,
    required this.relationships,
  });

  @override
  List<Object?> get props => [type, id, attributes, relationships];

  factory AlephooResponseData.fromJson(Map<String, dynamic> json) =>
      _$AlephooResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AlephooResponseDataToJson(this);
}

@JsonSerializable()
class AlephooResponseLink extends Equatable {
  final String self;

  const AlephooResponseLink({
    required this.self,
  });

  @override
  List<Object?> get props => [self];

  factory AlephooResponseLink.fromJson(Map<String, dynamic> json) =>
      _$AlephooResponseLinkFromJson(json);

  Map<String, dynamic> toJson() => _$AlephooResponseLinkToJson(this);
}

@JsonSerializable()
class AlephooResponseMeta extends Equatable {
  final List<dynamic> os;

  const AlephooResponseMeta({
    required this.os,
  });

  @override
  List<Object?> get props => [os];

  factory AlephooResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$AlephooResponseMetaFromJson(json);

  Map<String, dynamic> toJson() => _$AlephooResponseMetaToJson(this);
}
