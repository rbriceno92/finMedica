import 'package:app/features/login/presentation/bloc/sign_in_state.dart';
import 'package:app/util/validators.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/colors_fm.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_event.dart';

class UsernameWidget extends StatelessWidget {
  final SignInState state;
  const UsernameWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (email) => emailValidator(email, context),
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoratorLogin.getInputDecorator(
          Languages.of(context).emailText,
          !state.invalidCredentials ? Colors.white : ColorsFM.textInputError,
          ColorsFM.textInputError,
          labelColor: state.emailHasErrors || state.invalidCredentials
              ? ColorsFM.textInputError
              : Colors.white),
      style: TextStyle(
          color: state.emailHasErrors || state.invalidCredentials
              ? ColorsFM.textInputError
              : ColorsFM.primary99),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  String? emailValidator(String? emailText, BuildContext context) {
    context.read<SignInBloc>().add(EmailChange(email: emailText ?? ''));
    if (emailText?.isEmpty ?? true) {
      return '';
    } else if (!Validators.isEmailString(emailText ?? '')) {
      return '';
    } else {
      return null;
    }
  }
}
