import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SingUpSuccess extends StatelessWidget {
  const SingUpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: ColorsFM.primary,
      child: Stack(children: [
        SvgPicture.asset(
          texturaExito,
          width: width,
          height: height - bottomPadding,
          fit: BoxFit.fill,
        ),
        Positioned(
          top: topPadding,
          right: 0,
          left: 0,
          child: SizedBox(
            height: height - topPadding - bottomPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: extraLargeMargin),
                  child: SvgPicture.asset(
                    finMedicaLogo,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: largeMargin),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              iconStars,
                            ),
                            const SizedBox(
                              height: mediumMargin,
                            ),
                            Text(Languages.of(context).signUpSuccessTitle,
                                textAlign: TextAlign.center,
                                style: TypefaceStyles.poppinsSemiBold22
                                    .copyWith(color: Colors.white)),
                            const SizedBox(
                              height: marginStandard,
                            ),
                            Text(
                              Languages.of(context).signUpSuccessBody,
                              textAlign: TextAlign.center,
                              style:
                                  TypefaceStyles.bodyMediumMontserrat.copyWith(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(marginStandard),
                  child: ButtonText(
                    text: Languages.of(context).signInActionText,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        signInRoute,
                        ModalRoute.withName(welcomeRoute),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
