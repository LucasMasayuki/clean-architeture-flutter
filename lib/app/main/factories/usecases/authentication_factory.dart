import 'package:petdiary/app/data/usecases/remote_authentication.dart';
import 'package:petdiary/app/domain/usecases/authentication.dart';
import 'package:petdiary/app/main/factories/api/api_url)factory.dart';
import 'package:petdiary/app/main/factories/api/dio_client_factory.dart';

Authentication makeRemoteAuthentication() => RemoteAuthentication(
      dioClient: makeHttpAdapter(),
      url: makeApiUrl('login'),
    );
