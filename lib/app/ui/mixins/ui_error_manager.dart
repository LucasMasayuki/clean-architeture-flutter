import 'package:flutter/material.dart';
import 'package:petdiary/app/ui/components/error_message.dart';
import 'package:petdiary/app/ui/helpers/ui_error.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Stream<UIError> stream) {
    stream.listen((error) {
      if (error != null) {
        showErrorMessage(context, error.description);
      }
    });
  }
}
