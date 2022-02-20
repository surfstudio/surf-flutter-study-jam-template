import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/extensions/string_extensions.dart';

extension SnackBarShow on BuildContext {
  void showSnackBar(String? resource) {
    if (resource == null) return;
    final message = resource.getName(this, resource) ?? resource;
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
