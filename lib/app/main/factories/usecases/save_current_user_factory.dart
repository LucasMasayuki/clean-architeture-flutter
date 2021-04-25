import 'package:petdiary/app/data/usecases/save_current_user.dart';
import 'package:petdiary/app/domain/usecases/save_current_user.dart';
import 'package:petdiary/app/main/factories/cache/shared_preferences_adapter_factory.dart';

SaveCurrentUser makeLocalSaveCurrentUser() => LocalSaveCurrentUser(
      saveSharedPreferences: makeSharedPreferencesAdapter(),
    );
