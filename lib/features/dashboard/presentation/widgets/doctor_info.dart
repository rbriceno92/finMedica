import 'package:app/util/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/fonts_types.dart';

class DoctorInfo extends StatelessWidget {
  final String name;
  final String speciality;
  final String photo;
  const DoctorInfo(
      {Key? key,
      required this.name,
      required this.speciality,
      required this.photo})
      : super(key: key);
  final double heightCard = 55;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightCard,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                  width: 32,
                  height: 32,
                  color: ColorsFM.green95,
                  child: photo.isNotEmpty
                      ? Image.memory(
                          photo.decodeBase64(),
                          gaplessPlayback: true,
                        )
                      : SvgPicture.asset(
                          iconDoctor,
                          width: 2,
                          height: 2,
                          fit: BoxFit.scaleDown,
                          clipBehavior: Clip.none,
                        ))),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  speciality,
                  style: TypefaceStyles.poppinsSemiBold13NeutralDark,
                ),
                SizedBox(
                  width: 185,
                  child: Text(
                    name,
                    style: TypefaceStyles.poppinsRegular,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
