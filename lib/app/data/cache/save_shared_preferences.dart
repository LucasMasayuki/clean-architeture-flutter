import 'package:meta/meta.dart';

abstract class SaveSharedPreferences {
  Future<void> save({
    @required String key,
    @required String value,
  });
}
