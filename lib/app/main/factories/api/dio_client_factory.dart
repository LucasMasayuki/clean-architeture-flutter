import 'package:dio/dio.dart';
import 'package:petdiary/app/data/api/dio_client.dart';
import 'package:petdiary/app/infra/api/dio_adapter.dart';

DioClient makeHttpAdapter() => DioAdapter(Dio());
