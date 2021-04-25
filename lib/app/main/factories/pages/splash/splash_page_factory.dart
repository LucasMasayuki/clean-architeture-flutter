import 'package:flutter/material.dart';
import 'package:petdiary/app/ui/factories/pages/splash/splash_presenter_factory.dart';
import 'package:petdiary/app/ui/pages/splash/splash_page.dart';

Widget makeSplashPage() => SplashPage(presenter: makeGetxSplashPresenter());
