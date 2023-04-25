import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_bloc.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../util/colors_fm.dart';
import '../../../../../util/fonts_types.dart';
import '../../../domain/entities/consult.dart';
import '../../bloc/my_consult_event.dart';

class ConsultItem extends StatelessWidget {
  final Consult consult;
  final int position;
  const ConsultItem({Key? key, required this.consult, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: marginStandard, vertical: minMargin),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              border: Border.all(width: 1, color: ColorsFM.neutral99)),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(48),
                          child: Container(
                              width: 48,
                              height: 48,
                              color: consult.type.getIconColor(),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: consult.type == ConsultType.CANCELED
                                    ? const Icon(
                                        Icons.block,
                                        color: Colors.white,
                                      )
                                    : SvgPicture.asset(
                                        consult.type.getAssetList(),
                                        width: 32,
                                        height: 32,
                                        color: Colors.white,
                                      ),
                              ))),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: extraSmallMargin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${(consult.speciality) ?? 'Consulta'} - ${consult.type.getTypeTitle(context)}',
                                style: TypefaceStyles
                                    .poppinsSemiBold12NeutralDark
                                    .copyWith(
                                        color: consult.type ==
                                                    ConsultType.EXPIRED ||
                                                consult.type ==
                                                    ConsultType.NOT_ASSIST
                                            ? ColorsFM.neutralColor
                                            : ColorsFM.primary,
                                        fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                consult.date.consultsDateFormat(),
                                style: TypefaceStyles.poppinsRegular11.copyWith(
                                    color: ColorsFM.neutralColor, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 1,
                      color: ColorsFM.neutral99,
                    ),
                    const SizedBox(
                      width: smallMargin,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: smallMargin),
                      child: GestureDetector(
                        onTap: () {
                          consult.type == ConsultType.EXPIRED ||
                                  consult.type == ConsultType.COMPLETED ||
                                  consult.type == ConsultType.CANCELED ||
                                  consult.type == ConsultType.NOT_ASSIST
                              ? () {}
                              : context.read<MyConsultsBloc>().add(
                                  SetPrivacyState(
                                      privacy: !(consult.private),
                                      position: position));
                        },
                        child: SvgPicture.asset(
                          iconPrivacy,
                          color: consult.type == ConsultType.EXPIRED ||
                                  consult.type == ConsultType.COMPLETED ||
                                  consult.type == ConsultType.CANCELED ||
                                  consult.type == ConsultType.NOT_ASSIST
                              ? ColorsFM.neutral99
                              : consult.private
                                  ? ColorsFM.textInputError
                                  : ColorsFM.neutral90,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(myConsultsDetailRoute, arguments: consult);
        },
      ),
    );
  }
}
