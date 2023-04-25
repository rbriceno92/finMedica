import 'package:app/features/directory/data/models/clinic_model.dart';
import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/speciality_model.dart';

class DirectoryState extends Equatable {
  final bool isLoading;
  final Directory? directory;
  final int? specialist;
  final String? name;
  final ModelUser? user;
  final ClinicModel? clinic;
  final List<Speciality> specialities;
  final bool textSearch;
  final String message;

  const DirectoryState({
    this.isLoading = false,
    this.directory,
    this.specialist,
    this.name,
    this.user,
    this.clinic,
    this.specialities = const [],
    this.textSearch = false,
    this.message = '',
  });

  DirectoryState copyWith({
    bool? isLoading,
    Directory? directory,
    int? specialist,
    String? name,
    ModelUser? user,
    List<Speciality>? specialities,
    ClinicModel? clinic,
    bool? textSearch,
    String? message,
  }) {
    return DirectoryState(
        isLoading: isLoading ?? this.isLoading,
        directory: directory ?? this.directory,
        specialist: specialist ?? this.specialist,
        name: name ?? this.name,
        user: user ?? this.user,
        specialities: specialities ?? this.specialities,
        clinic: clinic ?? this.clinic,
        textSearch: textSearch ?? this.textSearch,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        isLoading,
        directory,
        specialist,
        name,
        user,
        specialities,
        clinic,
        textSearch,
        message
      ];
}
