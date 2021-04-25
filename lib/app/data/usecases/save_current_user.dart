import 'package:meta/meta.dart';
import 'package:petdiary/app/data/cache/save_shared_preferences.dart';
import 'package:petdiary/app/domain/entities/user_entity.dart';
import 'package:petdiary/app/domain/helpers/domain_errors.dart';
import 'package:petdiary/app/domain/usecases/save_current_user.dart';

class LocalSaveCurrentUser implements SaveCurrentUser {
  final SaveSharedPreferences saveSharedPreferences;

  LocalSaveCurrentUser({@required this.saveSharedPreferences});

  Future<void> save(UserEntity user) async {
    try {
      await saveSharedPreferences.save(key: 'token', value: user.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
