import 'package:app/features/signup/domain/use_cases/sign_up.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_event.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'sign_up_form_state.dart';
import 'package:logging/logging.dart';

final log = Logger('sign_up_form_bloc.dart');

class SignUpFormBloc extends Bloc<SignUpEvent, SignUpFormState> {
  SignUp signUp;

  SignUpFormBloc({required this.signUp}) : super(const SignUpFormState()) {
    on<FirstNameChange>(_onNameChange);
    on<SecondNameChange>(_onSecondNameChange);
    on<LastNameChange>(_onLastNameChange);
    on<MothersLastNameChange>(_onMothersLastNameChange);
    on<GenderChange>(_onGenderChange);
    on<PhoneChange>(_onPhoneChange);
    on<EmailChange>(_onEmailChange);
    on<CURPChange>(_onCURPChange);
    on<ChangeCURPInfoVisible>(_onChangeCURPInfoVisible);
    on<ChangeErrorEmailDuplicate>(_onChangeErrorEmailDuplicate);
    on<ChangeErrorCURPDuplicate>(_onChangeErrorCURPDuplicate);
    on<BirthdayChange>(_onDateBirthChange);
    on<SendSignUpData>(_onSendSignUpData);
    on<DisposeLoading>(_onDisposeLoading);
  }

  @override
  void onTransition(Transition<SignUpEvent, SignUpFormState> transition) {
    super.onTransition(transition);
  }

  void _onEmailChange(EmailChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      email: event.email,
      emailHasErrors: Validators.emptyString(event.email) ||
          !Validators.isEmailString(event.email),
      errorEmailDuplicate: false,
    ));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onNameChange(FirstNameChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
        firstName: event.firstName,
        nameHasErrors: Validators.emptyString(event.firstName) ||
            !Validators.isAlphanumeric(event.firstName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onSecondNameChange(
      SecondNameChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
        secondName: event.secondName,
        secondNameHasErrors: !Validators.isAlphanumeric(event.secondName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onLastNameChange(LastNameChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
        lastName: event.lastName,
        lastNameHasErrors: Validators.emptyString(event.lastName) ||
            !Validators.isAlphanumeric(event.lastName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onMothersLastNameChange(
      MothersLastNameChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
        mothersLastName: event.mothersLastName,
        mothersLasnameHasErrors:
            Validators.emptyString(event.mothersLastName) ||
                !Validators.isAlphanumeric(event.mothersLastName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onGenderChange(GenderChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onPhoneChange(PhoneChange event, Emitter<SignUpFormState> emit) {
    if (!Validators.emptyString(event.phone) &&
        (!Validators.isPhoneNumber(event.phone) || event.phone.length < 10)) {
      emit(state.copyWith(phone: event.phone, phoneHasErrors: true));
    } else {
      emit(state.copyWith(phone: event.phone, phoneHasErrors: false));
    }
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onCURPChange(CURPChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      curp: event.curp,
      curpHasError:
          Validators.emptyString(event.curp) || !Validators.isCURP(event.curp),
      errorCURPDuplicate: false,
    ));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onChangeCURPInfoVisible(
      ChangeCURPInfoVisible event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(showCURPInfo: !state.showCURPInfo));
  }

  void _onChangeErrorEmailDuplicate(
      ChangeErrorEmailDuplicate event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      errorEmailDuplicate: true,
      emailHasErrors: true,
    ));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onChangeErrorCURPDuplicate(
      ChangeErrorCURPDuplicate event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      errorCURPDuplicate: true,
      curpHasError: true,
    ));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onDateBirthChange(BirthdayChange event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      birthday: event.birthday,
      birthdayHasErrors: Validators.emptyString(event.birthday) ||
          !Validators.haveAtLeast(
              13, DateFormat('dd/MM/yyyy').parse(event.birthday)),
    ));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  bool _checkFormReady() {
    bool phoneCheck = false;

    if (state.phone.isEmpty ||
        (state.phone.isNotEmpty && state.phone.length > 9)) {
      phoneCheck = true;
    } else {
      phoneCheck = false;
    }

    return state.firstName.isNotEmpty &&
        !state.nameHasErrors &&
        state.lastName.isNotEmpty &&
        !state.lastNameHasErrors &&
        state.mothersLastName.isNotEmpty &&
        !state.mothersLasnameHasErrors &&
        state.curp.isNotEmpty &&
        !state.curpHasError &&
        state.gender != null &&
        !state.birthdayHasErrors &&
        phoneCheck &&
        !state.phoneHasErrors &&
        state.email.isNotEmpty &&
        !state.emailHasErrors;
  }

  void _onSendSignUpData(
      SendSignUpData event, Emitter<SignUpFormState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    try {
      var result = await signUp.call(event.data);

      bool emailE = false;
      bool curpE = false;
      String message = result.fold(
        (l) {
          if (l is ServerFailure) {
            if (l.modelServer.isSimple()) {
              return l.modelServer.message;
            } else {
              String tem = '';
              l.modelServer.message?.forEach((element) {
                if (element.type == 'EMAIL_NOT_AVAILABLE') {
                  emailE = true;
                } else if (element.type == 'DOCUMENT_ID_NOT_AVAILABLE') {
                  curpE = true;
                }
                if (element.type == 'EMAIL_AVAILABLE' ||
                    element.type == 'DOCUMENT_ID_AVAILABLE') {
                } else {
                  tem = tem.isEmpty
                      ? element.message
                      : '$tem, ${element.message}';
                }
              });
              return tem;
            }
          } else if (l is ErrorMessage) {
            return l.message;
          } else {
            return ERROR_MESSAGE;
          }
        },
        (r) {
          return '';
        },
      );
      emit(state.copyWith(
        errorEmailDuplicate: emailE,
        errorCURPDuplicate: curpE,
        emailHasErrors: emailE,
        curpHasError: curpE,
        errorMessage: message,
        loading: LoadingState.close,
      ));
      if (message.isEmpty && !emailE && !curpE) {
        event.next();
      }
    } catch (e) {
      log.severe('error', e);
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: UNEXPECTED_ERROR));
    }
  }

  void _onDisposeLoading(DisposeLoading event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(errorMessage: '', loading: LoadingState.dispose));
  }
}
