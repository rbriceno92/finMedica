import 'dart:async';

import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/features/directory/domain/entities/directory_by_specialist_and_name_param.dart';
import 'package:app/features/directory/domain/use_cases/get_directory_by_specialist_and_name.dart';
import 'package:app/features/directory/domain/use_cases/get_specialities.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../profile/domain/use_cases/get_user_info.dart';
import '../../../data/models/speciality_model.dart';
import '../../../domain/use_cases/get_clinic_use_case.dart';
import '../../../domain/use_cases/get_directory_by_specialist.dart';
import 'directory_event.dart';
import 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  GetDirectory getDirectory;
  GetSpecialities getSpecialities;
  GetDirectoryBySpecialistAndName getDirectoryBySpecialistAndName;
  final GetUserInfo userInfo;
  GetClinicUseCase getClinicUseCase;

  DirectoryBloc(
      {required this.getClinicUseCase,
      required this.getSpecialities,
      required this.getDirectory,
      required this.getDirectoryBySpecialistAndName,
      required this.userInfo})
      : super(const DirectoryState()) {
    on<LoadDirectory>(_onLoadDirectory);
    on<LoadDirectoryBySpecialistAndName>(_onLoadDirectoryBySpecialistAndName);
    on<LoadUser>(_onLoadUser);
    on<LoadSpecialities>(_onLoadSpecialities);
  }

  FutureOr<void> _onLoadDirectory(
      LoadDirectory event, Emitter<DirectoryState> emit) async {
    emit(state.copyWith(isLoading: true));

    var clinic = await getClinicUseCase.call(null);
    var specialities = await getSpecialities.call(null);

    await clinic.fold((l) => null, (clinic) async {
      var response = await getDirectory.call(clinic.alephooId);
      response.fold((error) {
        null;
      }, (data) {
        emit(state.copyWith(
            isLoading: false,
            directory: Directory(
                doctors: data.doctors
                    .map((e) => e.copyWith(address: clinic.address))
                    .toList()),
            clinic: clinic));
      });
    });

    final specialitiesList = <Speciality>[];

    specialities.fold((l) {
      emit(state.copyWith(
          isLoading: false, specialities: [], message: getMessage(l)));
    }, (r) {
      final speciality = Speciality(id: 0, name: 'Todas');
      specialitiesList.addAll(r);
      specialitiesList.sort((a, b) => a.name.compareTo(b.name));
      specialitiesList.insert(0, speciality);
      emit(state.copyWith(isLoading: false, specialities: specialitiesList));
    });
  }

  FutureOr<void> _onLoadDirectoryBySpecialistAndName(
      LoadDirectoryBySpecialistAndName event,
      Emitter<DirectoryState> emit) async {
    var textChange = false;
    int? specialist;
    if (event.name != null && (event.name?.isNotEmpty ?? false)) {
      textChange = true;
    }
    if (event.specialist == 0) {
      specialist = null;
    } else {
      specialist = event.specialist;
    }

    emit(state.copyWith(
        isLoading: true,
        specialist: event.specialist,
        name: event.name,
        textSearch: textChange));
    var response = await getDirectoryBySpecialistAndName.call(
        DirectoryBySpecialistAndNameParam(
            specialist: specialist,
            name: event.name,
            hospital: state.clinic?.alephooId ?? 1));
    response.fold((error) {
      if (error is ServerFailure) {
        if (error.modelServer.statusCode == 404) {
          emit(state.copyWith(
              isLoading: false, directory: const Directory(doctors: [])));
        } else {
          emit(state.copyWith(isLoading: false));
        }
      } else {
        emit(state.copyWith(isLoading: false));
      }
    }, (data) {
      emit(state.copyWith(
          isLoading: false,
          directory: Directory(
              doctors: data.doctors
                  .map((e) => e.copyWith(address: state.clinic?.address ?? ''))
                  .toList())));
    });
  }

  FutureOr<void> _onLoadUser(
      LoadUser event, Emitter<DirectoryState> emit) async {
    var user = await userInfo.repository.getUserInfo();
    user.fold((l) => null, (r) => emit(state.copyWith(user: r)));
  }

  FutureOr<void> _onLoadSpecialities(
      LoadSpecialities event, Emitter<DirectoryState> emit) async {
    var specialities = await getSpecialities.repository.getSpecialities();
    final specialitiesList = <Speciality>[];
    specialities.fold((l) => state.copyWith(specialities: null), (r) {
      final speciality = Speciality(id: 98898778, name: 'Todas');
      specialitiesList.add(speciality);
      specialitiesList.addAll(r);
      emit(state.copyWith(specialities: specialitiesList));
    });
  }

  String getMessage(ErrorGeneral l) {
    if (l is ServerFailure) {
      if (l.modelServer.isSimple()) {
        return l.modelServer.message ?? '';
      } else {
        return l.modelServer.message?.first.message ?? '';
      }
    }
    if (l is ErrorMessage) {
      return l.message;
    }
    return ERROR_MESSAGE;
  }
}
