import 'package:app/features/my_groups/domain/use_case/my_groups_new_member.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/general_fuctions.dart';
import 'package:app/util/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../util/constants/constants.dart';
import '../../data/models/create_new_member_request.dart';
import '../../domain/entities/my_groups_member.dart';
import 'my_groups_new_member_state.dart';
import 'my_groups_new_member_event.dart';

class MyGroupsNewMemberBloc
    extends Bloc<MyGroupsAddMemberEvent, MyGroupsNewMemberState> {
  MyGroupsNewMemberUseCase myGroupsNewMemberUseCase;
  MyGroupsNewMemberBloc({required this.myGroupsNewMemberUseCase})
      : super(const MyGroupsNewMemberState()) {
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
    on<DisposeLoading>(_onDisposeLoading);
    on<SendSignUpData>(_onSendSignUpData);
    on<SetGroupInfo>(_onSetAdminData);
  }

  void _onSetAdminData(
      SetGroupInfo event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(info: event.info));
  }

  @override
  void onTransition(
      Transition<MyGroupsAddMemberEvent, MyGroupsNewMemberState> transition) {
    super.onTransition(transition);
  }

  void _onEmailChange(EmailChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
      email: event.email,
      emailHasErrors: !Validators.emptyString(event.email) &&
          !Validators.isEmailString(event.email),
      errorEmailDuplicate: false,
    ));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onNameChange(
      FirstNameChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
        firstName: event.firstName,
        nameHasErrors: Validators.emptyString(event.firstName) ||
            !Validators.isNameOrLastname(event.firstName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onSecondNameChange(
      SecondNameChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
        secondName: event.secondName,
        secondNameHasErrors: !Validators.emptyString(event.secondName) &&
            !Validators.isNameOrLastname(event.secondName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onLastNameChange(
      LastNameChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
        lastName: event.lastName,
        lastNameHasErrors: Validators.emptyString(event.lastName) ||
            !Validators.isNameOrLastname(event.lastName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onMothersLastNameChange(
      MothersLastNameChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
        mothersLastName: event.mothersLastName,
        mothersLasnameHasErrors:
            Validators.emptyString(event.mothersLastName) ||
                !Validators.isNameOrLastname(event.mothersLastName)));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onGenderChange(
      GenderChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onPhoneChange(PhoneChange event, Emitter<MyGroupsNewMemberState> emit) {
    if (!Validators.emptyString(event.phone) &&
        (!Validators.isPhoneNumber(event.phone) || event.phone.length < 10)) {
      emit(state.copyWith(phone: event.phone, phoneHasErrors: true));
    } else {
      emit(state.copyWith(phone: event.phone, phoneHasErrors: false));
    }
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onCURPChange(CURPChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
      curp: event.curp,
      curpHasError:
          Validators.emptyString(event.curp) || !Validators.isCURP(event.curp),
      errorCURPDuplicate: false,
    ));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onChangeCURPInfoVisible(
      ChangeCURPInfoVisible event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(showCURPInfo: !state.showCURPInfo));
  }

  void _onChangeErrorEmailDuplicate(
      ChangeErrorEmailDuplicate event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
      errorEmailDuplicate: true,
      emailHasErrors: true,
    ));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onChangeErrorCURPDuplicate(
      ChangeErrorCURPDuplicate event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
      errorCURPDuplicate: true,
      curpHasError: true,
    ));
    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onDateBirthChange(
      BirthdayChange event, Emitter<MyGroupsNewMemberState> emit) {
    emit(state.copyWith(
      birthday: event.birthday,
      birthdayHasErrors: Validators.emptyString(event.birthday) ||
          !Validators.haveAtLeast(
              0, DateFormat('dd/MM/yyyy').parse(event.birthday)),
    ));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  bool _checkFormReady() {
    bool phoneCheck = false;

    if (state.phone == null) {
      phoneCheck = true;
    } else if (state.phone!.isEmpty ||
        (state.phone!.isNotEmpty && state.phone!.length > 9)) {
      phoneCheck = true;
    } else {
      phoneCheck = false;
    }

    return state.firstName.isNotEmpty &&
        state.mothersLastName.isNotEmpty &&
        !state.mothersLasnameHasErrors &&
        state.birthday.isNotEmpty &&
        !state.birthdayHasErrors &&
        !state.nameHasErrors &&
        state.lastName.isNotEmpty &&
        !state.lastNameHasErrors &&
        state.curp.isNotEmpty &&
        !state.curpHasError &&
        state.gender != null &&
        !state.birthdayHasErrors;
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<MyGroupsNewMemberState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose, errorMessage: ''));

  void _onSendSignUpData(
      SendSignUpData event, Emitter<MyGroupsNewMemberState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var phone = state.phone;
    if (phone != null && phone.trim().isEmpty) {
      phone = null;
    }

    var formData = CreateMyNewMemberRequest(
      firstName: state.firstName,
      secondName: state.secondName,
      lastName: state.lastName,
      mothersLastName: state.mothersLastName,
      birthday: state.birthday,
      email: state.email,
      documentId: state.curp,
      phoneNumber: phone,
      gender: state.gender?.name,
      age: howManyYears(state.birthday),
      idBoss: state.info!.idAdmin,
      groupId: state.info!.groupId,
    );
    var result = await myGroupsNewMemberUseCase.call(formData);
    result.fold((l) {
      var message = getMessage(l);
      emit(state.copyWith(loading: LoadingState.close, errorMessage: message));
    }, (r) {
      emit(state.copyWith(loading: LoadingState.close));
      event.next((MyGroupsMember(
        firstName: r.user?.firstName,
        lastName: r.user?.lastName,
        birthday: r.user?.birthday,
        age: r.user?.age,
        documentId: r.user?.documentId,
        email: r.user?.email,
        gender: r.user?.gender,
        userId: r.user?.userId,
        mothersLastName: r.user?.mothersLastName,
        phoneNumber: r.user?.phoneNumber,
        secondName: r.user?.secondName,
      )));
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
