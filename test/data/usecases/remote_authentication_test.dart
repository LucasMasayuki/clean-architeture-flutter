import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:petdiary/app/data/api/http_error.dart';
import 'package:petdiary/app/data/usecases/remote_authentication.dart';
import 'package:petdiary/app/domain/helpers/domain_errors.dart';
import 'package:petdiary/app/domain/usecases/authentication.dart';

import '../../mocks/dio_client_spy.dart';
import '../../mocks/fake_params_factory.dart';
import '../../mocks/fake_user_factory.dart';

void main() {
  RemoteAuthentication sut;
  DioClientSpy dioClient;
  String url;
  AuthenticationParams params;
  Map apiResult;

  PostExpectation mockRequest() => when(
        dioClient.post(
          any,
          data: anyNamed('data'),
        ),
      );

  void mockHttpData(Map<String, dynamic> data) {
    apiResult = data;
    mockRequest().thenAnswer(
      (_) async => data,
    );
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    dioClient = DioClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(dioClient: dioClient, url: url);
    params = FakeParamsFactory.makeAuthentication();
    mockHttpData(FakeUserFactory.makeApiJson());
  });

  test('Should call dioClient with correct values', () async {
    await sut.auth(params);

    verify(
      dioClient.post(
        url,
        data: {
          'email': params.email,
          'password': params.password,
        },
      ),
    );
  });

  test('Should throw UnexpectedError if dioClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if dioClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if dioClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if dioClient returns 401',
      () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an User if dioClient returns 200', () async {
    final user = await sut.auth(params);

    expect(user.token, apiResult['token']);
  });

  test(
      'Should throw UnexpectedError if dioClient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
