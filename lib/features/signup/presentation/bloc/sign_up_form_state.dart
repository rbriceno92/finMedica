import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class SignUpFormState extends Equatable {
  final String firstName;
  final String secondName;
  final String lastName;
  final String mothersLastName;
  final Genders? gender;
  final String phone;
  final String email;
  final String birthday;
  final String curp;
  final bool emailHasErrors;
  final bool nameHasErrors;
  final bool secondNameHasErrors;
  final bool lastNameHasErrors;
  final bool mothersLasnameHasErrors;
  final bool phoneHasErrors;
  final bool errorEmailDuplicate;
  final bool errorCURPDuplicate;
  final bool curpHasError;
  final bool showCURPInfo;
  final bool enableContinue;
  final bool birthdayHasErrors;
  final LoadingState loading;
  final String errorMessage;

  const SignUpFormState(
      {this.firstName = '',
      this.lastName = '',
      this.secondName = '',
      this.mothersLastName = '',
      this.gender,
      this.email = '',
      this.phone = '',
      this.secondNameHasErrors = false,
      this.nameHasErrors = false,
      this.lastNameHasErrors = false,
      this.mothersLasnameHasErrors = false,
      this.emailHasErrors = false,
      this.phoneHasErrors = false,
      this.birthday = '',
      this.errorEmailDuplicate = false,
      this.errorCURPDuplicate = false,
      this.curp = '',
      this.curpHasError = false,
      this.showCURPInfo = false,
      this.enableContinue = false,
      this.birthdayHasErrors = false,
      this.loading = LoadingState.dispose,
      this.errorMessage = ''});

  SignUpFormState copyWith(
      {String? firstName,
      String? secondName,
      String? lastName,
      String? mothersLastName,
      String? email,
      Genders? gender,
      String? phone,
      String? birthday,
      String? curp,
      bool? secondNameHasErrors,
      bool? nameHasErrors,
      bool? lastNameHasErrors,
      bool? mothersLasnameHasErrors,
      bool? emailHasErrors,
      bool? phoneHasErrors,
      bool? errorEmailDuplicate,
      bool? errorCURPDuplicate,
      bool? curpHasError,
      bool? showCURPInfo,
      bool? enableContinue,
      bool? birthdayHasErrors,
      LoadingState? loading,
      String? errorMessage}) {
    return SignUpFormState(
        firstName: firstName ?? this.firstName,
        secondName: secondName ?? this.secondName,
        lastName: lastName ?? this.lastName,
        mothersLastName: mothersLastName ?? this.mothersLastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        secondNameHasErrors: secondNameHasErrors ?? this.secondNameHasErrors,
        nameHasErrors: nameHasErrors ?? this.nameHasErrors,
        lastNameHasErrors: lastNameHasErrors ?? this.lastNameHasErrors,
        mothersLasnameHasErrors:
            mothersLasnameHasErrors ?? this.mothersLasnameHasErrors,
        emailHasErrors: emailHasErrors ?? this.emailHasErrors,
        phoneHasErrors: phoneHasErrors ?? this.phoneHasErrors,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        birthdayHasErrors: birthdayHasErrors ?? this.birthdayHasErrors,
        errorEmailDuplicate: errorEmailDuplicate ?? this.errorEmailDuplicate,
        errorCURPDuplicate: errorCURPDuplicate ?? this.errorCURPDuplicate,
        curpHasError: curpHasError ?? this.curpHasError,
        curp: curp ?? this.curp,
        showCURPInfo: showCURPInfo ?? this.showCURPInfo,
        enableContinue: enableContinue ?? this.enableContinue,
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        lastName,
        mothersLastName,
        gender,
        email,
        phone,
        nameHasErrors,
        secondNameHasErrors,
        lastNameHasErrors,
        mothersLasnameHasErrors,
        emailHasErrors,
        phoneHasErrors,
        birthday,
        birthdayHasErrors,
        errorEmailDuplicate,
        errorCURPDuplicate,
        curpHasError,
        curp,
        showCURPInfo,
        enableContinue,
        loading,
        errorMessage,
      ];
}
