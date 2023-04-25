import 'package:app/features/welcome/domain/entities/slice_props.dart';
import 'package:app/features/welcome/presentation/widgets/dot_widget.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:app/features/welcome/presentation/widgets/slice_widget.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final List<SliceProps> slices = [
      SliceProps(ColorsFM.primary80, welcomeBackgound1,
          Languages.of(context).slice1, welcomeImage1),
      SliceProps(ColorsFM.textInputError, welcomeBackgound2,
          Languages.of(context).slice2, welcomeImage2),
      SliceProps(ColorsFM.green80, welcomeBackgound3,
          Languages.of(context).slice3, welcomeImage3),
    ];

    return Container(
        color: ColorsFM.primary,
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: height - bottomPadding,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: slices.map((item) => Slice(item)).toList(),
            ),
            Positioned(
              top: topPadding,
              right: 0,
              left: 0,
              child: Container(
                  height: 64,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(finMedicaLogoWhite)),
            ),
            Positioned(
                bottom: bottomPadding,
                left: 0,
                right: 0,
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: slices.asMap().keys.map((index) {
                        return Dot(
                            isLast: index == slices.length - 1,
                            isSelected: _currentIndex == index);
                      }).toList()),
                  Container(
                      decoration: const BoxDecoration(
                          color: ColorsFM.primary,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      padding: const EdgeInsets.symmetric(
                        horizontal: marginStandard,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: marginStandard, top: mediumMargin),
                            child: Text(Languages.of(context).wouldLike,
                                style: TypefaceStyles.poppinsSemiBold22
                                    .copyWith(color: Colors.white)),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(bottom: marginStandard),
                            child: ButtonText(
                              text: Languages.of(context).signInActionText,
                              onPressed: () {
                                Navigator.pushNamed(context, signInRoute);
                              },
                            ),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(bottom: marginStandard),
                              child: ButtonText(
                                text: Languages.of(context).signUpAction,
                                onPressed: () {
                                  Navigator.pushNamed(context, signUproute);
                                },
                              )),
                        ],
                      ))
                ]))
          ],
        ));
  }
}
