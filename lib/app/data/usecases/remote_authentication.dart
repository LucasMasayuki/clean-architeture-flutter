import 'package:meta/meta.dart';
import 'package:petdiary/app/data/api/dio_client.dart';
import 'package:petdiary/app/data/api/http_error.dart';
import 'package:petdiary/app/data/models/remote_user_model.dart';
import 'package:petdiary/app/domain/entities/user_entity.dart';
import 'package:petdiary/app/domain/helpers/domain_errors.dart';
import 'package:petdiary/app/domain/usecases/authentication.dart';

class RemoteAuthentication implements Authentication {
  final DioClient dioClient;
  final String url;

  RemoteAuthentication({@required this.dioClient, @required this.url});

  Future<UserEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();

    try {
      final responseData = await dioClient.post(url, data: body);
      return RemoteUserModel.fromJson(responseData).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(
        email: params.email,
        password: params.password,
      );

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(
        {
          'email': email,
          'password': password,
        },
      );
}
