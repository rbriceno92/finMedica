import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_photo_model.g.dart';

@JsonSerializable()
class DoctorPhotoModel extends Equatable {
  final String photo;

  const DoctorPhotoModel({
    required this.photo,
  });

  factory DoctorPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorPhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPhotoModelToJson(this);

  @override
  List<Object> get props => [photo];
}
