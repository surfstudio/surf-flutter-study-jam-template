import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surf_practice_chat_flutter/config/localization.dart';

extension LocalizeName on String {
  /// Get by key from json language text
  String? getName(BuildContext context, String key) {
    return Localization.of(context)?.getTranslatedValue(key);
  }

  String toDateFormat({String pattern = "HH:mm dd.MM.yyyy"}) {
    final DateTime now = DateTime.parse(this);
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(now);
  }
}
