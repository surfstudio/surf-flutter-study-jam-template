import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/extensions/string_extensions.dart';
import 'package:surf_practice_chat_flutter/resources/strings.dart';

class InputValidator {
  final BuildContext context;

  InputValidator(this.context);

  String? isEmpty(String? val) {
    if (val == null) return null;
    if (val.isEmpty) {
      return _setText(Strings.error_field_is_empty);
    }

    if (val.isNotEmpty && val.length > 50) {
      return _setText(Strings.error_is_max_limit);
    }
    return null;
  }

  String? mayEmpty(String? val) {
    if (val == null) return null;
    if (val.isNotEmpty && val.length > 50) {
      return _setText(Strings.error_is_max_limit);
    }
    return null;
  }

  String? pinCode(String? val) {
    if (val == null) return null;
    if (val.isEmpty) {
      return _setText(Strings.error_field_is_empty);
    }

    if (val.isNotEmpty && val.length > 50) {
      return _setText(Strings.error_is_max_limit);
    }

    if (val.length < 4) {
      return _setText(Strings.error_invalid_field_length);
    }
    return null;
  }

  String _setText(String key) {
    return key.getName(context, key) ?? "";
  }
}
