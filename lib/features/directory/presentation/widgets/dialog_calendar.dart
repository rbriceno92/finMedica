import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../util/fonts_types.dart';
import '../../data/models/schedule_doctor.dart';
import '../bloc/schedule/schedule_bloc.dart';
import '../bloc/schedule/schedule_event.dart';
import 'package:app/util/format_date.dart';

class DialogCalendar extends StatefulWidget {
  DialogCalendar(
      {Key? key,
      required this.availableDates,
      required this.contextGeneral,
      required this.start,
      required this.end})
      : super(key: key);

  var dateState = DateTime.now();
  final DateTime start;
  final DateTime end;
  final List<DatesAvailable>? availableDates;
  final BuildContext contextGeneral;

  @override
  State<DialogCalendar> createState() => _DialogCalendarState();
}

class _DialogCalendarState extends State<DialogCalendar> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        widget.dateState.scheduleFormat(),
        textAlign: TextAlign.left,
        style: TypefaceStyles.poppinsRegular.copyWith(fontSize: 26),
      ),
      content: Container(
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: marginStandard,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: ColorsFM.neutral99,
            ),
            SizedBox(
              height: marginStandard,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: DayPicker.single(
                  datePickerStyles: DatePickerRangeStyles(
                    nextIcon: SvgPicture.asset(
                      arrowRight,
                      color: ColorsFM.neutral90,
                    ),
                    prevIcon: SvgPicture.asset(
                      arrowLeft,
                      color: ColorsFM.neutral90,
                    ),
                    currentDateStyle: TypefaceStyles.bodyMediumMontserrat
                        .copyWith(fontSize: 16, color: ColorsFM.green40),
                    displayedPeriodTitle:
                        TypefaceStyles.poppinsRegular.copyWith(fontSize: 16),
                    disabledDateStyle: TypefaceStyles.bodyMediumMontserrat
                        .copyWith(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16,
                            color: ColorsFM.neutralColor),
                    dayHeaderStyle: DayHeaderStyle(
                        textStyle: TypefaceStyles.poppinsRegular.copyWith(
                            color: ColorsFM.calendarHeaderColor, fontSize: 16)),
                    defaultDateTextStyle: TypefaceStyles.bodyMediumMontserrat
                        .copyWith(fontSize: 16),
                    selectedSingleDateDecoration: BoxDecoration(
                        color: ColorsFM.green40,
                        borderRadius: BorderRadius.circular(20)),
                    selectedDateStyle: TypefaceStyles.bodyMediumMontserrat
                        .copyWith(fontSize: 16, color: Colors.white),
                  ),
                  selectedDate: widget.dateState.scheduleFormat() ==
                          DateTime.now().scheduleFormat()
                      ? widget.start
                      : widget.dateState,
                  onChanged: (date) {
                    widget.dateState = date;
                    widget.contextGeneral
                        .read<ScheduleBloc>()
                        .add(SetDate(date: date));
                    setState(() {});
                  },
                  firstDate: widget.start,
                  lastDate: widget.end,
                  selectableDayPredicate: (date) {
                    if (widget.availableDates != null) {
                      final listOfDates =
                          widget.availableDates?.map((e) => e.date).toList();
                      if ((listOfDates?.contains(date.dateFormatCalendar())) ??
                          false) {
                        return true;
                      } else {
                        return false;
                      }
                    } else {
                      return false;
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Languages.of(context).accept)),
            )
          ],
        ),
      ),
    );
  }
}
