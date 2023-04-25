import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/fonts_types.dart';

class DoctorInfoDirectory extends StatelessWidget {
  final Doctor? doctor;
  const DoctorInfoDirectory({required this.doctor, Key? key}) : super(key: key);
  final double heightCard = 44;

  @override
  Widget build(BuildContext context) {
    String photo = doctor?.photo ?? '';
    return Container(
      height: heightCard,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          photo != ''
              ? Image.memory(
                  photo.decodeBase64(),
                  gaplessPlayback: true,
                  height: 24,
                  width: 24,
                )
              : SvgPicture.asset(iconDoctor, color: ColorsFM.neutralDark),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doctor?.fullName() ?? '--',
                  style: TypefaceStyles.poppinsSemiBold13NeutralDark,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  (doctor?.speciality?.isNotEmpty ?? false)
                      ? doctor?.speciality ?? ''
                      : 'Not speciality',
                  style: TypefaceStyles.poppinsRegular,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
