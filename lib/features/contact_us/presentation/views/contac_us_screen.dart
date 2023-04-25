import 'dart:math';

import 'package:app/core/di/modules.dart';
import 'package:app/features/contact_us/presentation/bloc/contact_us_bloc.dart';
import 'package:app/features/contact_us/presentation/bloc/contact_us_event.dart';
import 'package:app/features/contact_us/presentation/bloc/contact_us_state.dart';
import 'package:app/features/contact_us/presentation/widgets/form_text_area_field.dart';
import 'package:app/features/contact_us/presentation/widgets/form_text_field.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/widgets/spinner_loading.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ContactUsBloc>(),
      child: const ContactUsView(),
    );
  }
}

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerSubject = TextEditingController();
    TextEditingController controllerMessage = TextEditingController();

    return BlocConsumer<ContactUsBloc, ContactUsState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          context.read<ContactUsBloc>().add(DisposeLoading());
          Navigator.pop(context);
        }
        if (state.messageError != '' && state.loading == LoadingState.close) {
          AlertNotification.error(context, state.messageError);
          context.read<ContactUsBloc>().add(ClearMesssage());
        }
        if (state.messageSucces != '' && state.loading == LoadingState.close) {
          AlertNotification.success(
              context, Languages.of(context).contactMessage);
          context.read<ContactUsBloc>().add(ClearMesssage());
        }
        if (state.subject.isEmpty) {
          controllerSubject.text = '';
        }
        if (state.message.isEmpty) {
          controllerMessage.text = '';
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(Languages.of(context).contact),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: EdgeInsets.only(
              left: marginStandard,
              right: marginStandard,
              top: mediumMargin,
              bottom: MediaQuery.of(context).padding.bottom + marginStandard,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(Languages.of(context).contactUs,
                      style: TypefaceStyles.poppinsSemiBold22
                          .copyWith(color: ColorsFM.primary)),
                  const SizedBox(
                    height: marginStandard,
                  ),
                  Text(
                    Languages.of(context).sendUsYourComments,
                    style: TypefaceStyles.bodyMediumMontserrat,
                  ),
                  FormTextField(
                    controller: controllerSubject,
                    label: Languages.of(context).subject,
                    error: state.subject.length == 70,
                    errorBorderColor: Colors.grey,
                    errorLabelColor: false,
                    onChange: (value) {
                      context
                          .read<ContactUsBloc>()
                          .add(SubjectChange(text: value ?? ''));
                    },
                    maxLength: 70,
                  ),
                  FormTextAreaField(
                    maxLength: 500,
                    controller: controllerMessage,
                    label: Languages.of(context).yourMessage,
                    error: state.message.length == 500,
                    errorBorderColor: Colors.grey,
                    errorLabelColor: false,
                    lastItem: true,
                    onChange: (value) {
                      context
                          .read<ContactUsBloc>()
                          .add(MessageChange(text: value ?? ''));
                    },
                  ),
                  SizedBox(
                    height: calculateSeparation(
                        context, constraints.maxHeight, state),
                  ),
                  ButtonText(
                      text: Languages.of(context).send,
                      onPressed: state.enableContinue
                          ? () {
                              context
                                  .read<ContactUsBloc>()
                                  .add(const SendData());
                            }
                          : null)
                ]),
          ),
        ),
      ),
    );
  }

  double calculateSeparation(
      BuildContext context, double maxSize, ContactUsState state) {
    return max(
        maxSize -
            mediumMargin -
            MediaQuery.of(context).padding.bottom -
            marginStandard -
            446 -
            (state.subject.isNotEmpty ? 16 : 0) -
            (state.message.isNotEmpty ? 16 : 0),
        marginStandard);
  }
}
