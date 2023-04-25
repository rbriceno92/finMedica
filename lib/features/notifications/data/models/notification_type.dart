// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum NotificationType {
  @JsonValue('CONSULT_CANCEL')
  CANCELED,
  @JsonValue('CONSULT_SCHEDULE')
  SCHEDULE,
  @JsonValue('CONSULT_REFUND')
  REINTEGRED,
  @JsonValue('GROUP_ADDED')
  GROUP_ADDED,
  @JsonValue('GROUP_USER_OUT')
  GROUP_OUT
}
