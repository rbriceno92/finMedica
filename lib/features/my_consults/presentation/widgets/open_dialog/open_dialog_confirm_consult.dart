import 'package:app/util/assets_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../util/dimens.dart';
import '../../../../../util/fonts_types.dart';

class OpenDialogConfirmConsult extends StatelessWidget {
  const OpenDialogConfirmConsult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openDialogConfirmConsult(context);
      },
      child: SvgPicture.asset(
        iconAlert,
        color: Colors.black,
      ),
    );
  }

  void openDialogConfirmConsult(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            title: Center(
              child: Text(
                Languages.of(context).titleDialogScheduleAppointment,
                textAlign: TextAlign.center,
                style: TypefaceStyles.poppinsSemiBold,
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle)),
                    const SizedBox(
                      width: smallMargin,
                    ),
                    Expanded(
                      child: Text(
                        Languages.of(context)
                            .descriptionDialogScheduleAppointmentOne,
                        style: TypefaceStyles.bodyMediumMontserrat,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: marginStandard,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle)),
                    const SizedBox(
                      width: smallMargin,
                    ),
                    Expanded(
                      child: Text(
                        Languages.of(context)
                            .descriptionDialogScheduleAppointmentTwo,
                        style: TypefaceStyles.bodyMediumMontserrat,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: marginStandard,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle)),
                    const SizedBox(
                      width: smallMargin,
                    ),
                    Expanded(
                      child: Text(
                        Languages.of(context)
                            .descriptionDialogScheduleAppointmentThree,
                        style: TypefaceStyles.bodyMediumMontserrat,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: marginStandard,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Languages.of(context).continueText))
              ],
            ),
          );
        });
  }
}
