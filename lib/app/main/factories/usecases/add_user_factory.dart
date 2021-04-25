import 'package:petdiary/app/data/usecases/remote_add_user_.dart';
import 'package:petdiary/app/domain/usecases/add_user.dart';
import 'package:petdiary/app/main/factories/api/api_url)factory.dart';
import 'package:petdiary/app/main/factories/api/dio_client_factory.dart';

AddUser makeRemoteAddUser() => RemoteAddUser(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('signup'),
    );
