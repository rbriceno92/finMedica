import 'package:app/core/di/modules.dart';
import 'package:app/features/login/presentation/bloc/sign_in_bloc.dart';
import 'package:app/features/login/presentation/bloc/sign_in_event.dart';
import 'package:app/features/login/presentation/bloc/sign_in_state.dart';
import 'package:app/features/login/presentation/widgets/session_end.dart';
import 'package:app/features/login/presentation/widgets/sign_in_elements.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';

class SignInScreen extends StatelessWidget {
  final bool changedPassword;
  final bool sessionEnd;

  const SignInScreen(
      {Key? key, this.changedPassword = false, this.sessionEnd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>()
        ..add(ShowChangePasswordNotification(show: changedPassword))
        ..add(ShowSessionEndModal(show: sessionEnd))
        ..add(GetFirebaseToken()),
      child: SignInView(changedPassword: changedPassword),
    );
  }
}

class SignInView extends StatelessWidget {
  final bool changedPassword;

  const SignInView({super.key, required this.changedPassword});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      bloc: BlocProvider.of<SignInBloc>(context),
      listenWhen: (prevState, state) {
        return prevState != state;
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorsFM.primary,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 50,),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginStandard),
                  child: SignInElements(),
                )),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset(
                    finMedicaBottonImage,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, dashboardRoute, (Route route) => false);
        }
        if (state.invalidCredentials == true && state.showNotification) {
          AlertNotification.error(
              context, Languages.of(context).userPasswordNotValidate);
        } else if (state.status.isSubmissionFailure && state.showNotification) {
          AlertNotification.error(context,
              state.messageError ?? Languages.of(context).errorServerMessage);
        }
        if (state.showChangePasswordNotification && state.showNotification) {
          AlertNotification.success(
              context, Languages.of(context).changePasswordSuccess);
        }
        if (state.showNotification) {
          context.read<SignInBloc>().add(ChangeShowNotification());
        }
        if (state.showSessionEndModal) {
          showDialog(
            context: context,
            builder: (context) => const SessionEndAlert(),
          );
          context.read<SignInBloc>().add(ChangeShowEndModal());
        }
      },
    );
  }
}
