import 'dart:convert';

import 'package:flutter/foundation.dart';

extension StringFormatting on String {
  String capitalizeOnlyFirstWord() {
    if (trim().isEmpty) return '';

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String capitalizeAllWord({String separator = ' '}) {
    if (trim().isEmpty) return '';

    return split(separator)
        .map((e) => e.capitalizeOnlyFirstWord())
        .join(separator);
  }

  String disallowLeadingWhitespace() {
    return replaceFirst(RegExp(r'^\s'), '').replaceAll(RegExp('\\s+'), ' ');
  }

  Uint8List decodeBase64() {
    return const Base64Decoder().convert(split(',').last);
  }
}
