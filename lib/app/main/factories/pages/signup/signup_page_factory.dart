import 'package:flutter/material.dart';
import 'package:petdiary/app/main/factories/pages/signup/signup_presenter_factory.dart';
import 'package:petdiary/app/ui/pages/signup/signup_page.dart';

Widget makeSignUpPage() => SignUpPage(makeGetxSignUpPresenter());
