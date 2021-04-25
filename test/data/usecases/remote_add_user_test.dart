import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:petdiary/app/data/api/http_error.dart';
import 'package:petdiary/app/data/usecases/remote_add_user_.dart';
import 'package:petdiary/app/domain/helpers/domain_errors.dart';
import 'package:petdiary/app/domain/usecases/add_user.dart';

import '../../mocks/dio_client_spy.dart';
import '../../mocks/fake_params_factory.dart';
import '../../mocks/fake_user_factory.dart';

void main() {
  RemoteAddUser sut;
  DioClientSpy httpClient;
  String url;
  AddUserParams params;
  Map apiResult;

  PostExpectation mockRequest() => when(
        httpClient.post(
          any,
          data: anyNamed('data'),
        ),
      );

  void mockHttpData(Map<String, dynamic> data) {
    apiResult = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    httpClient = DioClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddUser(httpClient: httpClient, url: url);
    params = FakeParamsFactory.makeAddUser();
    mockHttpData(FakeUserFactory.makeApiJson());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.add(params);

    verify(
      httpClient.post(
        url,
        data: {
          'name': params.name,
          'email': params.email,
          'password': params.password,
          'passwordConfirmation': params.passwordConfirmation
        },
      ),
    );
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 403',
      () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final account = await sut.add(params);

    expect(account.token, apiResult['token']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
