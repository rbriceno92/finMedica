import 'dart:async';

import 'package:app/features/profile/domain/use_cases/get_user_info.dart';
import 'package:app/features/profile/presentation/bloc/profile_event.dart';
import 'package:app/features/profile/presentation/bloc/profile_state.dart';
import 'package:app/util/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/failure.dart';
import '../../../../util/user_preferences_save.dart';
import '../../domain/entities/update_data.dart';
import '../../domain/use_cases/update_data_user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserInfo userInfo;
  final UpdateDataUser updateData;
  final UserPreferenceDao sharedPreferences;

  ProfileBloc(
      {required this.userInfo,
      required this.updateData,
      required this.sharedPreferences})
      : super(const ProfileState()) {
    on<OnGetUserInfo>(_onGetUserInfo);
    on<OnSaveEmail>(_onSaveEmail);
    on<OnSavePhone>(_onSavePhone);
    on<OnShowCurpInfo>(_onShowCurpInfo);
    on<CleanMessage>(_onCleanMessage);
  }

  FutureOr<void> _onGetUserInfo(
      OnGetUserInfo event, Emitter<ProfileState> emit) async {
    var user = await userInfo.repository.getUserInfo();
    user.fold((error) {
      emit(state.copyWith(
        modelUser: null,
        messageError: 'User info not finded',
      ));
    }, (user) {
      emit(state.copyWith(
          modelUser: user, messageError: '', phone: user.phoneNumber));
    });
  }

  FutureOr<void> _onSavePhone(
      OnSavePhone event, Emitter<ProfileState> emit) async {
    var result = await updateData.call(UpdateData(phone: event.phone));
    result.fold(
      (l) {
        if (l is ServerFailure) {
          if (l.modelServer.isSimple()) {
            emit(state.copyWith(
                messageError: (l.modelServer.message as String)));
          } else {
            emit(state.copyWith(
                messageError: (l.modelServer.message as List<MessageModel>)
                    .map((e) => e.message)
                    .join(', ')));
          }
        }
        if (l is ErrorMessage) {
          emit(state.copyWith(messageError: l.message));
        }
      },
      (r) {
        emit(
            state.copyWith(phone: event.phone, messageSuccess: '${r.message}'));
        var user = state.modelUser!.copyWith(phoneNumber: event.phone);
        sharedPreferences.saveUser(user);
      },
    );
  }

  FutureOr<void> _onSaveEmail(OnSaveEmail event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
        modelUser: state.modelUser?.copyWith(email: event.email)));
  }

  FutureOr<void> _onShowCurpInfo(
      OnShowCurpInfo event, Emitter<ProfileState> emit) {
    emit(state.copyWith(showCurpInfo: !state.showCurpInfo));
  }

  FutureOr<void> _onCleanMessage(
      CleanMessage event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(messageError: '', messageSuccess: ''));
  }
}
