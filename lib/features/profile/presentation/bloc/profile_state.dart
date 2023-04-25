import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String? messageSuccess;
  final ModelUser? modelUser;
  final String messageError;
  final String? email;
  final String? phone;
  final bool showCurpInfo;

  const ProfileState(
      {this.email,
      this.phone,
      this.modelUser,
      this.messageError = '',
      this.messageSuccess = '',
      this.showCurpInfo = false});

  ProfileState copyWith(
      {ModelUser? modelUser,
      String? messageError,
      String? messageSuccess,
      String? email,
      String? phone,
      bool? showCurpInfo}) {
    return ProfileState(
        messageSuccess: messageSuccess ?? this.messageSuccess,
        modelUser: modelUser ?? this.modelUser,
        messageError: messageError ?? this.messageError,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        showCurpInfo: showCurpInfo ?? this.showCurpInfo);
  }

  @override
  List<Object?> get props =>
      [modelUser, messageError, messageSuccess, email, phone, showCurpInfo];
}
