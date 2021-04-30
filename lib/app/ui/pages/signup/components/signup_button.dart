import 'package:flutter/material.dart';
import 'package:petdiary/app/ui/helpers/i18n/resources.dart';

class SignUpButton extends StatelessWidget {
  final Stream<bool> isFormValidStream;
  final Function signUp;

  const SignUpButton({
    @required this.isFormValidStream,
    @required this.signUp,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? signUp : null,
          child: Text(R.string.addAccount.toUpperCase()),
        );
      },
    );
  }
}
