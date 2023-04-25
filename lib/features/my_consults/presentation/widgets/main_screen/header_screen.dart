import 'package:app/navigation/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../util/assets_routes.dart';
import '../../../../../util/colors_fm.dart';
import '../../../../../util/dimens.dart';
import '../../../../../util/fonts_types.dart';

class HeaderScreen extends StatelessWidget {
  final int numConsults;

  const HeaderScreen({Key? key, required this.numConsults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 155,
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
        color: ColorsFM.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(iconHeaderLeaf)),
            Padding(
              padding: const EdgeInsets.only(left: largeMargin, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disponibles',
                    style: TypefaceStyles.poppinsRegular
                        .copyWith(fontSize: 40, color: ColorsFM.neutral99),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$numConsults Consultas',
                        style: TypefaceStyles.poppinsSemiBold28
                            .copyWith(fontSize: 24, color: ColorsFM.green60),
                      ),
                      const SizedBox(
                        width: marginStandard,
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(
                          iconConfiguration,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(confidentialityScreen);
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
