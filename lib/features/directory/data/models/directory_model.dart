import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directory_model.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: true)
class DirectoryModel extends Directory {
  const DirectoryModel({required super.doctors});

  factory DirectoryModel.fromJson(Map<String, dynamic> json) =>
      _$DirectoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DirectoryModelToJson(this);
}
