import 'package:app/features/login/presentation/bloc/sign_in_state.dart';
import 'package:app/features/login/presentation/widgets/password_widget.dart';
import 'package:app/features/login/presentation/widgets/username_widget.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_event.dart';

class SignInElements extends StatelessWidget {
  const SignInElements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(finMedicaLogo),
          ),
          const SizedBox(
            height: largeDivision,
          ),
          Text(
            Languages.of(context).signInText,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: largeDivision,
          ),
          UsernameWidget(state: state),
          const SizedBox(
            height: marginStandard,
          ),
          PasswordWidget(
            state: state,
          ),
          const SizedBox(
            height: smallMargin,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, forgotPasswordRoute);
            },
            child: Text(Languages.of(context).forgotPasswordQuestionText,
                style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(
            height: largeMargin,
          ),
          ElevatedButton(
              onPressed: state.enableForm
                  ? () {
                      context.read<SignInBloc>().add(SigningIn());
                    }
                  : null,
              child: Text(
                Languages.of(context).signInActionText,
                style: TextStyle(
                    color: state.enableForm
                        ? Colors.white
                        : ColorsFM.neutralColor),
              )),
          const SizedBox(
            height: smallMargin,
          ),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, signUproute),
              child: Text(Languages.of(context).notUserYetText,
                  style: const TextStyle(color: Colors.white)),
            ),
          )
        ],
      );
    });
  }
}
