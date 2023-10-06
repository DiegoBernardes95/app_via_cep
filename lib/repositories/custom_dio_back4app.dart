import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDioBack4App{
  final _dio = Dio();

  Dio get dio => _dio;

  CustomDioBack4App(){
    _dio.options.headers['X-Parse-Application-Id'] = dotenv.get("BACK4APPAPPLICATIONID");
    _dio.options.headers['X-Parse-REST-API-Key'] = dotenv.get("BACK4FORAPPAPIKEY");
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = dotenv.get('BACK4APPBASEURL');
  }
}