import 'package:app/util/assets_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/widgets/input_decorator.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_event.dart';
import '../bloc/sign_in_state.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({Key? key, required this.state}) : super(key: key);

  final SignInState state;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (password) => passwordValidator(password, context),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.white,
        obscureText: state.showPassword,
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(
            color: state.passwordHasErrors || state.invalidCredentials
                ? ColorsFM.textInputError
                : ColorsFM.primary99),
        decoration: InputDecoratorLogin.getInputDecorator(
                Languages.of(context).passwordText,
                !state.invalidCredentials
                    ? Colors.white
                    : ColorsFM.textInputError,
                ColorsFM.textInputError,
                labelColor: state.passwordHasErrors || state.invalidCredentials
                    ? ColorsFM.textInputError
                    : Colors.white)
            .copyWith(
          suffixIcon: IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(ShowPasswordToggle());
              },
              icon: state.showPassword
                  ? SvgPicture.asset(
                      eyeIconOpen,
                      color: state.passwordHasErrors || state.invalidCredentials
                          ? ColorsFM.textInputError
                          : Colors.white,
                    )
                  : SvgPicture.asset(
                      eyeIconClosed,
                      color: state.passwordHasErrors || state.invalidCredentials
                          ? ColorsFM.textInputError
                          : Colors.white,
                    )),
        ));
  }

  String? passwordValidator(String? passwordText, BuildContext context) {
    context
        .read<SignInBloc>()
        .add(PasswordChange(password: passwordText ?? ''));
    if (passwordText?.isEmpty ?? true) {
      return '';
    } else if (passwordText!.length < 3) {
      return '';
    } else {
      return null;
    }
  }
}
