import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:petdiary/app/infra/cache/shared_preferences_adapter.dart';

import '../../mocks/shared_preferences_spy.dart';

void main() {
  SharedPreferencesAdapter sut;
  SharedPreferencesSpy preferences;
  String key;
  String value;

  setUp(() {
    preferences = SharedPreferencesSpy();
    sut = SharedPreferencesAdapter(preferences: preferences);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  group('save', () {
    void mockSaveSecureError() => when(
          preferences.setString(
            any,
            any,
          ),
        ).thenThrow(Exception());

    test('Should call save secure with correct values', () async {
      await sut.save(key: key, value: value);

      verify(preferences.setString(key, value));
    });

    test('Should throw if save secure throws', () async {
      mockSaveSecureError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(isA<Exception>()));
    });
  });

  group('fetch', () {
    PostExpectation mockFetchSecureCall() => when(preferences.getString(any));

    void mockFetchSecure() => mockFetchSecureCall().thenAnswer((_) => value);

    void mockFetchSecureError() => mockFetchSecureCall().thenThrow(Exception());

    setUp(() {
      mockFetchSecure();
    });

    test('Should call fetch secure with correct value', () async {
      await sut.fetch(key);

      verify(preferences.getString(key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await sut.fetch(key);

      expect(fetchedValue, value);
    });

    test('Should throw if fetch secure throws', () async {
      mockFetchSecureError();

      final future = sut.fetch(key);

      expect(future, throwsA(isA<Exception>()));
    });
  });

  group('delete', () {
    void mockDeleteSecureError() => when(
          preferences.remove(
            any,
          ),
        ).thenThrow(Exception());

    test('Should call delete with correct key', () async {
      await sut.delete(key);

      verify(preferences.remove(key)).called(1);
    });

    test('Should throw if delete throws', () async {
      mockDeleteSecureError();

      final future = sut.delete(key);

      expect(future, throwsA(isA<Exception>()));
    });
  });
}
