import 'package:petdiary/app/domain/entities/user_entity.dart';

abstract class SaveCurrentUser {
  Future<void> save(UserEntity user);
}
