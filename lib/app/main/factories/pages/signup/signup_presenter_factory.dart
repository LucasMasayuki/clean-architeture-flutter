import 'package:petdiary/app/main/factories/pages/signup/signup_validation_factory.dart';
import 'package:petdiary/app/main/factories/usecases/add_user_factory.dart';
import 'package:petdiary/app/main/factories/usecases/save_current_user_factory.dart';
import 'package:petdiary/app/presentation/presenters/getx_signup_presenter.dart';
import 'package:petdiary/app/ui/pages/signup/signup_presenter.dart';

SignUpPresenter makeGetxSignUpPresenter() => GetxSignUpPresenter(
      addUser: makeRemoteAddUser(),
      validation: makeSignUpValidation(),
      saveCurrentUser: makeLocalSaveCurrentUser(),
    );
