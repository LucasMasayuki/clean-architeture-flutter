import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:petdiary/app/data/usecases/save_current_user.dart';
import 'package:petdiary/app/domain/entities/user_entity.dart';
import 'package:petdiary/app/domain/helpers/domain_errors.dart';

import '../../mocks/save_secure_cache_storage_spy.dart';

void main() {
  LocalSaveCurrentUser sut;
  SaveSharedPreferencesSpy saveSharedPreferences;
  UserEntity user;

  void mockError() => when(
        saveSharedPreferences.save(
          key: anyNamed('key'),
          value: anyNamed('value'),
        ),
      ).thenThrow(Exception());

  setUp(() {
    saveSharedPreferences = SaveSharedPreferencesSpy();
    sut = LocalSaveCurrentUser(saveSharedPreferences: saveSharedPreferences);
    user = UserEntity(token: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(user);

    verify(saveSharedPreferences.save(key: 'token', value: user.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    mockError();

    final future = sut.save(user);

    expect(future, throwsA(DomainError.unexpected));
  });
}
