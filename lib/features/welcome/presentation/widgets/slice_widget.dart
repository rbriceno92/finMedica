import 'package:app/features/welcome/domain/entities/slice_props.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Slice extends StatelessWidget {
  final SliceProps props;

  const Slice(this.props, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;
    final height = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
        color: props.backgroundColor,
        child: Stack(
          children: [
            SvgPicture.asset(
              props.backgroundImage,
              width: width,
            ),
            Positioned(
              top: topPadding + 64,
              right: 0,
              left: 0,
              child: Container(
                  // height - SafeArea.top - AppBar - BottomElements - SafeArea.bottom,
                  height: height - topPadding - 64 - 218 - bottomPadding,
                  padding:
                      const EdgeInsets.symmetric(horizontal: marginStandard),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: marginStandard),
                        child: SvgPicture.asset(props.image),
                      ),
                      Text(props.description,
                          textAlign: TextAlign.center,
                          style: TypefaceStyles.poppinsSemiBold28)
                    ],
                  )),
            )
          ],
        ));
  }

  toList() {}
}
