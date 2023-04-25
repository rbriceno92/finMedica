import 'package:app/core/di/modules.dart';
import 'package:app/features/signup/domain/entities/sign_up_data.dart';
import 'package:app/features/signup/presentation/views/sign_up_code_screen.dart';
import 'package:app/features/terms_conditions/presentation/bloc/terms_conditions_bloc.dart';
import 'package:app/features/terms_conditions/presentation/bloc/terms_conditions_event.dart';
import 'package:app/features/terms_conditions/presentation/bloc/terms_conditions_state.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_svg/svg.dart';

enum TCScreenFrom { signUp, dashboard }

class TCScreenArgs {
  final TCScreenFrom from;
  final SignUpData? signUpData;
  final bool? acceptedTerms;
  final String? name;

  TCScreenArgs(
      {required this.from, this.signUpData, this.acceptedTerms, this.name});
}

class TermsConditionsScreen extends StatelessWidget {
  final TCScreenArgs args;
  const TermsConditionsScreen(this.args, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TermsConditionsBloc>()
        ..add(AcceptedTermsChange(acceptedTerms: args.acceptedTerms ?? false))
        ..add(DonwloadTerms()),
      child: TermsConditionsView(args: args),
    );
  }
}

class TermsConditionsView extends StatelessWidget {
  final TCScreenArgs args;
  const TermsConditionsView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TermsConditionsBloc, TermsConditionsState>(
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: SvgPicture.asset(
            finMedicaLogo,
            alignment: Alignment.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: marginStandard,
              right: marginStandard,
              bottom: MediaQuery.of(context).padding.bottom + smallMargin,
              top: mediumMargin),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: marginStandard),
                    child: Text(Languages.of(context).termConditions,
                        style: TypefaceStyles.poppinsSemiBold22
                            .copyWith(color: ColorsFM.primary)),
                  ),
                  Expanded(
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Scrollbar(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Html(
                                  data: state.terms,
                                  style: {
                                    'body': Style(
                                        fontFamily: 'Montserrat',
                                        margin: Margins.zero,
                                        padding: EdgeInsets.zero,
                                        height: Height.auto()),
                                  },
                                ),
                                if (state.error.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: marginStandard),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            value: state.acceptedTerms,
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return ColorsFM.neutral95;
                                              } else {
                                                return ColorsFM.primary;
                                              }
                                            }),
                                            onChanged: args.from ==
                                                    TCScreenFrom.dashboard
                                                ? null
                                                : (value) {
                                                    context
                                                        .read<
                                                            TermsConditionsBloc>()
                                                        .add(
                                                            AcceptedTermsChange(
                                                                acceptedTerms:
                                                                    value ??
                                                                        false));
                                                  },
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth - 48,
                                            child: Text(
                                              Languages.of(context)
                                                  .declaresAccept,
                                            ),
                                          )
                                        ]),
                                  )
                              ]),
                        ),
                      );
                    }),
                  ),
                  if (args.from == TCScreenFrom.signUp)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: marginStandard),
                        child: ButtonText(
                          text: Languages.of(context).continueText,
                          onPressed: state.acceptedTerms && state.error.isEmpty
                              ? () => context.read<TermsConditionsBloc>().add(
                                    SendSignUpData(
                                        data: args.signUpData!,
                                        error: (message) {
                                          Future.delayed(const Duration(
                                                  milliseconds: 100))
                                              .then((value) =>
                                                  AlertNotification.error(
                                                      context, message));
                                        },
                                        next: (userId) {
                                          Future
                                                  .delayed(
                                                      const Duration(
                                                          milliseconds: 100))
                                              .then((value) =>
                                                  Navigator.pushNamed(context,
                                                      signUpCode,
                                                      arguments:
                                                          SignUpCodeParams(
                                                              email: args
                                                                  .signUpData!
                                                                  .email,
                                                              userId:
                                                                  userId ?? '',
                                                              name: args.name ??
                                                                  '')));
                                        }),
                                  )
                              : null,
                        ),
                      ),
                    )
                ]);
          }),
        ),
      ),
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          Navigator.pop(context);
          context.read<TermsConditionsBloc>().add(DisposeLoading());
          if (state.error.isNotEmpty) {
            AlertNotification.error(context, state.error);
          }
        }
      },
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }
}
