import 'package:petdiary/app/data/usecases/local_load_current_user.dart';
import 'package:petdiary/app/domain/usecases/load_current_user.dart';
import 'package:petdiary/app/main/factories/cache/shared_preferences_adapter_factory.dart';

LoadCurrentUser makeLocalLoadCurrentUser() => LocalLoadCurrentUser(
    fetchSharedPreferences: makeSharedPreferencesAdapter());
