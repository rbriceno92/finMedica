// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:app/features/change_password/data/models/change_password_request.dart';
import 'package:app/features/change_password/data/models/change_password_response.dart';
import 'package:app/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:app/features/change_password/presentation/bloc/change_password_bloc.dart';
import 'package:app/features/change_password/presentation/bloc/change_password_event.dart';
import 'package:app/features/change_password/presentation/bloc/change_password_state.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_bloc_test.mocks.dart';

@GenerateMocks([ChangePasswordRepository])
void main() {
  late ChangePasswordUseCase changePasswordUseCase;
  late MockChangePasswordRepository mockRepository;
  final file =
      File('test/features/change_password/bloc/update_password_responses.json');

  group('Test password field state:', () {
    setUp(() {
      mockRepository = MockChangePasswordRepository();
      changePasswordUseCase = ChangePasswordUseCase(repository: mockRepository);
    });
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Ingress a invalid password',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(const PasswordChange(password: '')),
      expect: () =>
          [const ChangePasswordState(password: '', passwordHasErrors: true)],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Ingress a valid password',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(const PasswordChange(password: 'Tera123.')),
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123.', passwordHasErrors: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Press on tew eye one time',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(ChangePasswordVisible()),
      expect: () => [const ChangePasswordState(showPassword: true)],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Press on tew eye two time',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(ChangePasswordVisible())
        ..add(ChangePasswordVisible()),
      expect: () => [
        const ChangePasswordState(showPassword: true),
        const ChangePasswordState(showPassword: false)
      ],
    );
  });
  group('Test new password field states:', () {
    setUp(() {
      mockRepository = MockChangePasswordRepository();
      changePasswordUseCase = ChangePasswordUseCase(repository: mockRepository);
    });
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Ingress a invalid password',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(const NewPasswordChange(password: '')),
      expect: () => [
        const ChangePasswordState(newPassword: '', newPasswordHasErrors: true)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Ingress a valid password',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(const NewPasswordChange(password: 'Tera123.')),
      expect: () => [
        const ChangePasswordState(
            newPassword: 'Tera123.', newPasswordHasErrors: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Press on the eye one time',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(ChangeNewPasswordVisible()),
      expect: () => [const ChangePasswordState(showNewPassword: true)],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Press on the eye two time',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(ChangeNewPasswordVisible())
        ..add(ChangeNewPasswordVisible()),
      expect: () => [
        const ChangePasswordState(showNewPassword: true),
        const ChangePasswordState(showNewPassword: false)
      ],
    );
  });
  group('Test confirm password field states', () {
    setUp(() {
      mockRepository = MockChangePasswordRepository();
      changePasswordUseCase = ChangePasswordUseCase(repository: mockRepository);
    });
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Confirm is empty and new not modificate (empty)',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(const ConfirmePasswordChange(password: '')),
      expect: () => [
        const ChangePasswordState(
            confirmePassword: '', confirmePasswordHasErrors: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Confirm is not empty and new not modificate (empty)',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) =>
          bloc.add(const ConfirmePasswordChange(password: 'Tera123.')),
      expect: () => [
        const ChangePasswordState(
            confirmePassword: 'Tera123.', confirmePasswordHasErrors: true)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'New password is not empty and valid but confirm is empty',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const NewPasswordChange(password: 'Tera123.'))
        ..add(const ConfirmePasswordChange(password: '')),
      skip: 1,
      expect: () => [
        const ChangePasswordState(
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: '',
            confirmePasswordHasErrors: true)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'New password has a valid password and confirm is not empty',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const NewPasswordChange(password: 'Tera123.'))
        ..add(const ConfirmePasswordChange(password: 'Asdf123*')),
      skip: 1,
      expect: () => [
        const ChangePasswordState(
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: 'Asdf123*',
            confirmePasswordHasErrors: true)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'New password has a valid password and confirm is equal',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const NewPasswordChange(password: 'Tera123.'))
        ..add(const ConfirmePasswordChange(password: 'Tera123.')),
      skip: 1,
      expect: () => [
        const ChangePasswordState(
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Press on password eye one time',
      setUp: () {
        mockRepository = MockChangePasswordRepository();
        changePasswordUseCase =
            ChangePasswordUseCase(repository: mockRepository);
      },
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc.add(ChangeConfirmPasswordVisible()),
      expect: () => [const ChangePasswordState(showConfirmePassword: true)],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Press on password eye two time',
      setUp: () {
        mockRepository = MockChangePasswordRepository();
        changePasswordUseCase =
            ChangePasswordUseCase(repository: mockRepository);
      },
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(ChangeConfirmPasswordVisible())
        ..add(ChangeConfirmPasswordVisible()),
      expect: () => [
        const ChangePasswordState(showConfirmePassword: true),
        const ChangePasswordState(showConfirmePassword: false)
      ],
    );
  });
  group('Test enable submit bottom:', () {
    setUp(() {
      mockRepository = MockChangePasswordRepository();
      changePasswordUseCase = ChangePasswordUseCase(repository: mockRepository);
    });
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'All fields are invalid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'T'))
        ..add(const NewPasswordChange(password: 'T'))
        ..add(const ConfirmePasswordChange(password: 'T')),
      skip: 2,
      expect: () => [
        const ChangePasswordState(
            password: 'T',
            passwordHasErrors: true,
            newPassword: 'T',
            newPasswordHasErrors: true,
            confirmePassword: 'T',
            confirmePasswordHasErrors: false,
            enableContinue: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Password is valid, other fields are invalid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'Tera123.'))
        ..add(const NewPasswordChange(password: 'T'))
        ..add(const ConfirmePasswordChange(password: 'T')),
      skip: 2,
      expect: () => [
        const ChangePasswordState(
          password: 'Tera123.',
          passwordHasErrors: false,
          newPassword: 'T',
          newPasswordHasErrors: true,
          confirmePassword: 'T',
          confirmePasswordHasErrors: false,
          enableContinue: false,
        )
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'New Password is valid, other fields are invalid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'T'))
        ..add(const NewPasswordChange(password: 'Tera123.'))
        ..add(const ConfirmePasswordChange(password: 'T')),
      skip: 2,
      expect: () => [
        const ChangePasswordState(
          password: 'T',
          passwordHasErrors: true,
          newPassword: 'Tera123.',
          newPasswordHasErrors: false,
          confirmePassword: 'T',
          confirmePasswordHasErrors: true,
          enableContinue: false,
        )
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Confirm Password is valid, other fields are invalid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'T'))
        ..add(const NewPasswordChange(password: 'T'))
        ..add(const ConfirmePasswordChange(password: 'Tera123.')),
      skip: 2,
      expect: () => [
        const ChangePasswordState(
            password: 'T',
            passwordHasErrors: true,
            newPassword: 'T',
            newPasswordHasErrors: true,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: true,
            enableContinue: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Password is invalid, other fields are valid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'T'))
        ..add(const NewPasswordChange(password: 'Tera123.'))
        ..add(const ConfirmePasswordChange(password: 'Tera123.')),
      skip: 2,
      expect: () => [
        const ChangePasswordState(
            password: 'T',
            passwordHasErrors: true,
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: false,
            enableContinue: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'New Password is invalid, other fields are valid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'Tera123.'))
        ..add(const NewPasswordChange(password: 'T'))
        ..add(const ConfirmePasswordChange(password: 'Tera123.')),
      skip: 2,
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123.',
            passwordHasErrors: false,
            newPassword: 'T',
            newPasswordHasErrors: true,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: true,
            enableContinue: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Confirm Password is invalid, other fields are valid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'Tera123.'))
        ..add(const NewPasswordChange(password: 'Tera123.'))
        ..add(const ConfirmePasswordChange(password: 'T')),
      skip: 2,
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123.',
            passwordHasErrors: false,
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: 'T',
            confirmePasswordHasErrors: true,
            enableContinue: false)
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'All field are valid',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      act: (bloc) => bloc
        ..add(const PasswordChange(password: 'Tera123.'))
        ..add(const NewPasswordChange(password: 'Tera123.'))
        ..add(const ConfirmePasswordChange(password: 'Tera123.')),
      skip: 3,
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123.',
            passwordHasErrors: false,
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: false,
            enableContinue: true),
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'All field are valid, old and new password are the same, then press continue',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      seed: () {
        return const ChangePasswordState(
            password: 'Tera123.',
            newPassword: 'Tera123.',
            confirmePassword: 'Tera123.',
            enableContinue: true);
      },
      act: (bloc) => bloc
        ..add(SendRequest(
          onError: (message) => print('onError: $message'),
          onSuccess: () => print('onSuccess'),
        )),
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123.',
            passwordHasErrors: false,
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: false,
            enableContinue: false,
            samePasswordError: true),
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Change password after try to send data, when old and new password are the same',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      seed: () {
        return const ChangePasswordState(
            password: 'Tera123.',
            newPassword: 'Tera123.',
            confirmePassword: 'Tera123.',
            enableContinue: false,
            samePasswordError: true);
      },
      act: (bloc) => bloc..add(const PasswordChange(password: 'Tera123..')),
      skip: 1,
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123..',
            passwordHasErrors: false,
            newPassword: 'Tera123.',
            newPasswordHasErrors: false,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: false,
            enableContinue: true,
            samePasswordError: false),
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'Change new password after try to send data, when old and new password are the same',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      seed: () {
        return const ChangePasswordState(
            password: 'Tera123.',
            newPassword: 'Tera123.',
            confirmePassword: 'Tera123.',
            enableContinue: false,
            samePasswordError: true);
      },
      act: (bloc) => bloc..add(const NewPasswordChange(password: 'Tera123..')),
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123.',
            passwordHasErrors: false,
            newPassword: 'Tera123..',
            newPasswordHasErrors: false,
            confirmePassword: 'Tera123.',
            confirmePasswordHasErrors: true,
            enableContinue: false,
            samePasswordError: false),
      ],
    );
  });
  group('Test send data:', () {
    setUp(() async {
      mockRepository = MockChangePasswordRepository();
      changePasswordUseCase = ChangePasswordUseCase(repository: mockRepository);
    });

    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'sucess response',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      setUp: () async {
        final json = jsonDecode(await file.readAsString());
        when(mockRepository.updatePassword(
          ChangePasswordRequest(
              password: md5.convert(utf8.encode('Tera123..')).toString(),
              currentPassword: md5.convert(utf8.encode('Tera123.')).toString()),
        )).thenAnswer((_) async =>
            Right(ChangePasswordResponse.fromJson(json['success'])));
      },
      seed: () {
        return const ChangePasswordState(
            password: 'Tera123.',
            newPassword: 'Tera123..',
            confirmePassword: 'Tera123..',
            enableContinue: true);
      },
      act: (bloc) => bloc.add(SendRequest(
        onError: (message) => print('onError: $message'),
        onSuccess: () => print('onSuccess'),
      )),
      verify: ((bloc) {
        verify(mockRepository.updatePassword(
          ChangePasswordRequest(
              password: md5.convert(utf8.encode('Tera123..')).toString(),
              currentPassword: md5.convert(utf8.encode('Tera123.')).toString()),
        )).called(1);
        verifyNoMoreInteractions(mockRepository);
      }),
      expect: () => [
        const ChangePasswordState(
            password: 'Tera123.',
            newPassword: 'Tera123..',
            confirmePassword: 'Tera123..',
            loading: true,
            enableContinue: true),
        const ChangePasswordState(
          loading: true,
        ),
        const ChangePasswordState()
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'error current password empty',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      setUp: () async {
        final json = jsonDecode(await file.readAsString());
        when(mockRepository.updatePassword(
          ChangePasswordRequest(
              password: md5.convert(utf8.encode('Tera123..')).toString(),
              currentPassword: md5.convert(utf8.encode('')).toString()),
        )).thenAnswer((_) async => Left(ServerFailure(
            modelServer: ErrorModelServer.fromJson(
                json['error_current_password_empty']))));
      },
      seed: () {
        return const ChangePasswordState(
          newPassword: 'Tera123..',
          confirmePassword: 'Tera123..',
        );
      },
      act: (bloc) => bloc.add(SendRequest(
        onError: (message) => print('onError: $message'),
        onSuccess: () => print('onSuccess'),
      )),
      verify: ((bloc) {
        verify(mockRepository.updatePassword(ChangePasswordRequest(
                password: md5.convert(utf8.encode('Tera123..')).toString(),
                currentPassword: md5.convert(utf8.encode('')).toString())))
            .called(1);
        verifyNoMoreInteractions(mockRepository);
      }),
      expect: () => [
        const ChangePasswordState(
          newPassword: 'Tera123..',
          newPasswordHasErrors: false,
          confirmePassword: 'Tera123..',
          confirmePasswordHasErrors: false,
          loading: true,
        ),
        const ChangePasswordState(
          newPassword: 'Tera123..',
          newPasswordHasErrors: false,
          confirmePassword: 'Tera123..',
          confirmePasswordHasErrors: false,
        )
      ],
    );
    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'error new password empty',
      build: () =>
          ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
      seed: () {
        return const ChangePasswordState(password: 'Tera123.');
      },
      setUp: () async {
        final json = jsonDecode(await file.readAsString());
        when(mockRepository.updatePassword(
          ChangePasswordRequest(
              password: md5.convert(utf8.encode('')).toString(),
              currentPassword: md5.convert(utf8.encode('Tera123.')).toString()),
        )).thenAnswer((_) async => Left(ServerFailure(
            modelServer:
                ErrorModelServer.fromJson(json['error_password_empty']))));
      },
      act: (bloc) => bloc.add(SendRequest(
        onError: (message) => print('onError: $message'),
        onSuccess: () => print('onSuccess'),
      )),
      verify: ((bloc) {
        verify(mockRepository.updatePassword(ChangePasswordRequest(
                password: md5.convert(utf8.encode('')).toString(),
                currentPassword:
                    md5.convert(utf8.encode('Tera123.')).toString())))
            .called(1);
        verifyNoMoreInteractions(mockRepository);
      }),
      expect: () => [
        const ChangePasswordState(
          password: 'Tera123.',
          loading: true,
        ),
        const ChangePasswordState(
          password: 'Tera123.',
        )
      ],
    );
    // blocTest<ChangePasswordBloc, ChangePasswordState>(
    //   'error both empty',
    //   build: () =>
    //       ChangePasswordBloc(changePasswordUseCase: changePasswordUseCase),
    //   act: (bloc) => bloc.add(SendRequest(
    //     onError: (message) => print('onError: $message'),
    //     onSuccess: () => print('onSuccess'),
    //   )),
    //   setUp: () async {
    //     final json = jsonDecode(await file.readAsString());
    //     when(mockRepository.updatePassword(
    //       ChangePasswordRequest(
    //           password: md5.convert(utf8.encode('')).toString(),
    //           currentPassword: md5.convert(utf8.encode('')).toString()),
    //     )).thenAnswer((_) async => Left(ErrorModelList(
    //         modelError: ErrorModelComplex.fromJson(json['error_both_empty']))));
    //   },
    //   verify: ((bloc) {
    //     verify(mockRepository.updatePassword(ChangePasswordRequest(
    //             password: md5.convert(utf8.encode('')).toString(),
    //             currentPassword: md5.convert(utf8.encode('')).toString())))
    //         .called(1);
    //     verifyNoMoreInteractions(mockRepository);
    //   }),
    //   expect: () => [
    //     const ChangePasswordState(
    //       loading: true,
    //     ),
    //     const ChangePasswordState()
    //   ],
    // );
  });
}
