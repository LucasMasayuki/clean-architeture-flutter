import 'package:meta/meta.dart';
import 'package:petdiary/app/data/api/dio_client.dart';
import 'package:petdiary/app/data/api/http_error.dart';
import 'package:petdiary/app/data/models/remote_user_model.dart';
import 'package:petdiary/app/domain/entities/user_entity.dart';
import 'package:petdiary/app/domain/helpers/domain_errors.dart';
import 'package:petdiary/app/domain/usecases/add_user.dart';

class RemoteAddUser implements AddUser {
  final DioClient httpClient;
  final String url;

  RemoteAddUser({
    @required this.httpClient,
    @required this.url,
  });

  Future<UserEntity> add(AddUserParams params) async {
    final body = RemoteAddUserParams.fromDomain(params).toJson();

    try {
      final responseData = await httpClient.post(
        url,
        data: body,
      );

      return RemoteUserModel.fromJson(responseData).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.emailInUse
          : DomainError.unexpected;
    }
  }
}

class RemoteAddUserParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddUserParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation,
  });

  factory RemoteAddUserParams.fromDomain(AddUserParams params) =>
      RemoteAddUserParams(
        name: params.name,
        email: params.email,
        password: params.password,
        passwordConfirmation: params.passwordConfirmation,
      );

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(
        {
          'name': name,
          'email': email,
          'password': password,
          'passwordConfirmation': passwordConfirmation,
        },
      );
}
