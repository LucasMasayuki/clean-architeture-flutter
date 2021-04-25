import 'package:flutter/material.dart';
import 'package:petdiary/app/main/factories/pages/login/login_presenter_factory.dart';
import 'package:petdiary/app/ui/pages/login/login_page.dart';

Widget makeLoginPage() => LoginPage(makeGetxLoginPresenter());
