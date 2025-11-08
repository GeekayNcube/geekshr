import 'package:dio/dio.dart';

abstract class HttpService {
  Future<Response> getRequest(String url);
  Future<Response> delete(String url);
  Future<Response> post(String url, dynamic data);
}
