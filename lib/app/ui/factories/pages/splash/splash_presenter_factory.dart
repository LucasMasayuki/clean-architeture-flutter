import 'package:petdiary/app/main/factories/usecases/load_current_user_factory.dart';
import 'package:petdiary/app/presentation/presenters/getx_splash_presenter.dart';
import 'package:petdiary/app/ui/pages/splash/splash_presenter.dart';

SplashPresenter makeGetxSplashPresenter() =>
    GetxSplashPresenter(loadCurrentUser: makeLocalLoadCurrentUser());
