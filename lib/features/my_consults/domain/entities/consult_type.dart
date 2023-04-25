// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';

enum ConsultType {
  @JsonValue('Pendiente')
  SCHEDULE,
  @JsonValue('Reagendada')
  REPROGRAMMING,
  @JsonValue('Cancelado')
  CANCELED,
  @JsonValue('Realizado')
  COMPLETED,
  @JsonValue('No asistió')
  NOT_ASSIST,
  @JsonValue('Expirada')
  EXPIRED,
  @JsonValue('No atendido')
  ATTENDED,
  @JsonValue('SCHEDULING')
  SCHEDULING,
  ALL
}

extension ConsultTypes on ConsultType {
  Color getColorByTypeOfHeader() {
    switch (this) {
      case ConsultType.REPROGRAMMING:
        return Colors.white;
      case ConsultType.CANCELED:
        return ColorsFM.textInputError;
      case ConsultType.COMPLETED:
        return ColorsFM.primaryLight99;
      case ConsultType.EXPIRED:
      case ConsultType.NOT_ASSIST:
        return ColorsFM.primaryLight99;
      case ConsultType.ATTENDED:
        return ColorsFM.primaryLight99;
      default:
        return ColorsFM.primaryLight99;
    }
  }

  Color getColorByType() {
    switch (this) {
      case ConsultType.REPROGRAMMING:
        return ColorsFM.green20;
      case ConsultType.CANCELED:
        return ColorsFM.errorColor;
      case ConsultType.COMPLETED:
        return ColorsFM.primary80;
      case ConsultType.EXPIRED:
      case ConsultType.NOT_ASSIST:
        return ColorsFM.neutralColor;
      case ConsultType.ATTENDED:
        return ColorsFM.neutralColor;
      default:
        return ColorsFM.green40;
    }
  }

  String getTypeTitle(BuildContext context) {
    switch (this) {
      case ConsultType.SCHEDULE:
        return Languages.of(context).consultScheduled;
      case ConsultType.SCHEDULING:
        return Languages.of(context).consultScheduled;
      case ConsultType.REPROGRAMMING:
        return Languages.of(context).consultReprogramming;
      case ConsultType.CANCELED:
        return Languages.of(context).consultCanceled;
      case ConsultType.COMPLETED:
        return Languages.of(context).consultCompleted;
      case ConsultType.EXPIRED:
      case ConsultType.NOT_ASSIST:
        return Languages.of(context).consultExpired;
      case ConsultType.ATTENDED:
        return Languages.of(context).consultExpired;
      default:
        return Languages.of(context).consultAll;
    }
  }

  String getTypeTitleDetail(BuildContext context) {
    switch (this) {
      case ConsultType.SCHEDULE:
        return Languages.of(context).consultScheduled;
      case ConsultType.SCHEDULING:
        return Languages.of(context).consultScheduled;
      case ConsultType.REPROGRAMMING:
        return Languages.of(context).reprogramming;
      case ConsultType.CANCELED:
        return Languages.of(context).cancellation;
      case ConsultType.COMPLETED:
        return Languages.of(context).consultCompleted;
      case ConsultType.EXPIRED:
      case ConsultType.NOT_ASSIST:
        return Languages.of(context).consultExpired;
      case ConsultType.ATTENDED:
        return Languages.of(context).consultExpired;
      default:
        return Languages.of(context).consultAll;
    }
  }

  String getDateTitleByType(BuildContext context) {
    switch (this) {
      case ConsultType.REPROGRAMMING:
        return Languages.of(context).rescheduledDate;
      case ConsultType.CANCELED:
        return Languages.of(context).cancelledDate;
      case ConsultType.COMPLETED:
        return Languages.of(context).rescheduledDate;
      default:
        return Languages.of(context).date;
    }
  }

  //For icons
  Color getIconColor() {
    switch (this) {
      case ConsultType.REPROGRAMMING:
        return ColorsFM.green20;
      case ConsultType.CANCELED:
        return ColorsFM.errorColor;
      case ConsultType.COMPLETED:
        return ColorsFM.primary80;
      case ConsultType.EXPIRED:
      case ConsultType.NOT_ASSIST:
        return ColorsFM.neutralColor;
      case ConsultType.ATTENDED:
        return ColorsFM.neutralColor;
      default:
        return ColorsFM.green40;
    }
  }

  String getAssetList() {
    switch (this) {
      case ConsultType.REPROGRAMMING:
        return iconSchedule;
      case ConsultType.CANCELED:
        return iconSchedule;
      default:
        return iconConsults;
    }
  }

  String getAssetDetailedConsult() {
    if (this == ConsultType.CANCELED) {
      return iconCancelConsult;
    } else {
      return iconScheduleConsult;
    }
  }

  String getTextDateChangedByType(BuildContext context) {
    if (this == ConsultType.REPROGRAMMING) {
      return Languages.of(context).dateRescheduledBy;
    } else {
      return Languages.of(context).dateCanceledBy;
    }
  }

  String getTextDateCreatedBy(BuildContext context) {
    switch (this) {
      case ConsultType.SCHEDULE:
        return Languages.of(context).dateScheduledBy;
      case ConsultType.EXPIRED:
      case ConsultType.NOT_ASSIST:
        return Languages.of(context).dateScheduledBy;
      case ConsultType.ATTENDED:
        return Languages.of(context).dateScheduledBy;
      case ConsultType.CANCELED:
        return Languages.of(context).dateScheduledBy;
      case ConsultType.REPROGRAMMING:
        return Languages.of(context).dateRescheduledBy;
      default:
        return Languages.of(context).createdDateBy;
    }
  }

  Color getDoctorBackgroungColorByType() {
    switch (this) {
      case ConsultType.SCHEDULE:
        return ColorsFM.green95;
      case ConsultType.COMPLETED:
        return ColorsFM.primaryLight80;
      default:
        return ColorsFM.neutral95;
    }
  }

  Color getDoctorUserLogoColorByType() {
    switch (this) {
      case ConsultType.SCHEDULING:
        return ColorsFM.green80;
      case ConsultType.COMPLETED:
        return ColorsFM.primary80;
      default:
        return ColorsFM.neutralColor;
    }
  }
}
