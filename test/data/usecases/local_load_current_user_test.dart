import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:petdiary/app/data/usecases/local_load_current_user.dart';
import 'package:petdiary/app/domain/entities/user_entity.dart';
import 'package:petdiary/app/domain/helpers/domain_errors.dart';

import '../../mocks/fetch_shared_preferences_spy.dart';

void main() {
  LocalLoadCurrentUser sut;
  FetchSharedPreferencesSpy fetchSharedPreferences;
  String token;

  PostExpectation mockFetchSecureCall() =>
      when(fetchSharedPreferences.fetch(any));

  void mockFetchSecure() =>
      mockFetchSecureCall().thenAnswer((_) async => token);

  void mockFetchSecureError() => mockFetchSecureCall().thenThrow(Exception());

  setUp(() {
    fetchSharedPreferences = FetchSharedPreferencesSpy();
    sut = LocalLoadCurrentUser(
      fetchSharedPreferences: fetchSharedPreferences,
    );

    token = faker.guid.guid();
    mockFetchSecure();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSharedPreferences.fetch('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, UserEntity(token: token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws',
      () async {
    mockFetchSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
