import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/modules.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';
import '../../../../util/fonts_types.dart';
import '../../../../util/widgets/alert_notification.dart';
import '../../../../util/widgets/spinner_loading.dart';
import '../bloc/frequent_questions_bloc.dart';
import '../bloc/frequent_questions_event.dart';
import '../bloc/frequent_questions_state.dart';

class FrequentQuestionsScreen extends StatelessWidget {
  const FrequentQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FrequentQuestionsBloc>(
      create: (context) =>
          getIt<FrequentQuestionsBloc>()..add(DonwloadFrequentQuestions()),
      child: const _FrequentQuestionsView(),
    );
  }
}

class _FrequentQuestionsView extends StatelessWidget {
  const _FrequentQuestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(Languages.of(context).frecuentQuestions),
        ),
        body: BlocConsumer<FrequentQuestionsBloc, FrequentQuestionsState>(
          listener: (context, state) {
            if (state.loading) {
              SpinnerLoading.showDialogLoading(context);
            }
            if (!state.loading) {
              Navigator.pop(context);
            }
            if (state.errorMessage != '') {
              AlertNotification.error(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state.loading) {
              return Container();
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: marginStandard, horizontal: marginStandard),
                    child: Text(
                      Languages.of(context).frecuentQuestions,
                      style: TypefaceStyles.poppinsSemiBold24Primary,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ...?state.frequentQuestions?.map(
                    (faq) {
                      return Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: Column(
                            children: [
                              ExpansionTile(
                                collapsedIconColor: ColorsFM.neutral90,
                                iconColor: ColorsFM.neutral90,
                                textColor: ColorsFM.neutralDark,
                                collapsedTextColor: ColorsFM.neutralDark,
                                childrenPadding:
                                    const EdgeInsets.only(top: 0.0),
                                title: Text(
                                  '${faq['question']}',
                                  style: TypefaceStyles.buttonPoppinsSemiBold14,
                                ),
                                children: [
                                  ListTile(
                                      title: Text(
                                          style: TypefaceStyles
                                              .bodySmallMontserrat12,
                                          '${faq['answer']}')),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                              const Divider(
                                  indent: 16.00,
                                  endIndent: 16.00,
                                  height: 1.00,
                                  thickness: 1.00,
                                  color: ColorsFM.primary99),
                            ],
                          ));
                    },
                  ).toList(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          },
        ));
  }
}
