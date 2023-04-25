import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScheduleAppointmentSuccessScreen extends StatelessWidget {
  final bool isPaid;
  const ScheduleAppointmentSuccessScreen({super.key, this.isPaid = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorsFM.primaryLight99,
      appBar: AppBar(
          backgroundColor: ColorsFM.green40,
          title: Text(Languages.of(context).scheduleAppointment)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: marginStandard),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: marginStandard),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          iconConsults,
                          color: ColorsFM.green40,
                          height: 80,
                        ),
                        const SizedBox(height: marginStandard),
                        Text(
                          Languages.of(context).consultScheduledSuccessfully,
                          style: TypefaceStyles.poppinsSemiBold22
                              .copyWith(color: ColorsFM.primary),
                          textAlign: TextAlign.center,
                        ),
                        if (!isPaid) ...[
                          const SizedBox(height: marginStandard),
                          Text(
                            Languages.of(context).payConsultonTheSpot,
                            style: TypefaceStyles.bodyMediumMontserrat
                                .copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const SizedBox(height: marginStandard),
                        Text(
                          Languages.of(context).receiveConfirmationEmail,
                          style: TypefaceStyles.bodyMediumMontserrat,
                          textAlign: TextAlign.center,
                        ),
                      ]),
                ),
              ),
              ButtonText(
                text: Languages.of(context).homepage,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, dashboardRoute);
                },
              ),
              const SizedBox(
                height: marginStandard,
              )
            ],
          ),
        ),
      ),
    );
  }
}
