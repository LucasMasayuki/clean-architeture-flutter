import 'package:flutter/material.dart';
import 'package:petdiary/app/ui/helpers/i18n/resources.dart';
import 'package:petdiary/app/ui/helpers/ui_error.dart';

class NameInput extends StatelessWidget {
  final Stream<UIError> nameErrorStream;
  final Function validateName;

  const NameInput({
    @required this.nameErrorStream,
    @required this.validateName,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UIError>(
      stream: nameErrorStream,
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
          onChanged: validateName,
        );
      },
    );
  }
}
