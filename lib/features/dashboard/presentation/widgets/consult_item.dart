import 'package:app/features/dashboard/presentation/widgets/patient_info.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';

import '../../../../util/colors_fm.dart';
import '../../../my_consults/domain/entities/consult.dart';
import 'date_info.dart';
import 'doctor_info.dart';

//Widget who has the info of the doctor, patient and the date of the next consult
class ConsultItem extends StatelessWidget {
  final Consult consult;
  const ConsultItem({Key? key, required this.consult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: minMargin),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusRoundedButton),
              topRight: Radius.circular(cornerRounded),
              bottomRight: Radius.circular(cornerRounded),
              bottomLeft: Radius.circular(cornerRounded))),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorInfo(
                    name: consult.doctor?.name ?? '',
                    speciality: '${consult.speciality}',
                    photo: consult.doctor?.photo ?? '',
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: minMargin, bottom: 2),
                    width: double.infinity,
                    height: 1,
                    color: ColorsFM.primary99,
                  ),
                  PatientInfo(name: '${consult.patient?.name}')
                ],
              ),
            ),
          ),
          DateInfo(
            consult: consult,
            date: '${consult.dateNextConsult}',
            time: '${consult.timeNextConsult}',
          )
        ],
      ),
    );
  }
}
