import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdiary/app/ui/helpers/i18n/resources.dart';
import 'package:petdiary/app/ui/helpers/ui_error.dart';
import 'package:petdiary/app/ui/pages/signup/signup_presenter.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignUpPresenter presenter = Get.find();

    return StreamBuilder<UIError>(
      stream: presenter.nameErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.string.name,
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColorLight,
            ),
            errorText: snapshot.hasData ? snapshot.data.description : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: presenter.validateName,
        );
      },
    );
  }
}
