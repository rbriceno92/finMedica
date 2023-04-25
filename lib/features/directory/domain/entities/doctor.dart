import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app/util/string_extensions.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor extends Equatable {
  @JsonKey(name: 'persona_id')
  final int? personId;
  @JsonKey(name: 'professional_id')
  final int professionalId;
  final String? name;
  final String? lastname;
  final String? genre;
  final String? speciality;
  final int? specialityId;
  @JsonKey(name: 'phonenumber')
  final String? phoneNumber;
  final String? location;
  final String? address;
  final String photo;
  final String? prefix;
  final String? observation;

  const Doctor({
    this.name,
    this.personId,
    this.lastname,
    this.genre,
    this.phoneNumber,
    required this.professionalId,
    required this.speciality,
    required this.specialityId,
    this.location,
    this.address,
    this.photo = '',
    this.prefix,
    this.observation,
  });

  Doctor copyWith({
    int? personId,
    int? professionalId,
    String? name,
    String? lastname,
    String? genre,
    String? speciality,
    int? specialityId,
    String? phoneNumber,
    String? location,
    String? address,
    String? photo,
    String? prefix,
    String? observation,
  }) =>
      Doctor(
        personId: personId ?? this.personId,
        professionalId: professionalId ?? this.professionalId,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        genre: genre ?? this.genre,
        speciality: speciality ?? this.speciality,
        specialityId: specialityId ?? this.specialityId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        location: location ?? this.location,
        address: address ?? this.address,
        photo: photo ?? this.photo,
        prefix: prefix ?? this.prefix,
        observation: observation ?? this.observation,
      );

  @override
  List<Object?> get props => [
        name,
        lastname,
        personId,
        genre,
        phoneNumber,
        professionalId,
        speciality,
        specialityId,
        location,
        address,
        photo,
        prefix,
        observation,
      ];

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  String fullName() {
    List<String> parts = [
      prefix?.capitalizeOnlyFirstWord() ?? '',
      name?.capitalizeOnlyFirstWord() ?? '',
      lastname?.capitalizeOnlyFirstWord() ?? ''
    ];

    String full = parts.where((part) => part.isNotEmpty).join(' ');
    return full.isEmpty ? '--' : full;
  }
}
