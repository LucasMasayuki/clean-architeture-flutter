import 'package:flutter/material.dart';
import 'package:petdiary/app/ui/helpers/i18n/resources.dart';
import 'package:petdiary/app/ui/helpers/ui_error.dart';

class EmailInput extends StatelessWidget {
  final Stream<UIError> emailErrorStream;
  final Function validateEmail;

  const EmailInput({
    @required this.emailErrorStream,
    @required this.validateEmail,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UIError>(
      stream: emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.string.email,
            icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.hasData ? snapshot.data.description : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: validateEmail,
        );
      },
    );
  }
}
