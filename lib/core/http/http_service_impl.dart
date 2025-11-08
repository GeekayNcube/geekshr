import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HttpService.dart';

const BASE_URL = "https://service.geekshr.co.uk:8083/";

class HttpServiceImpl implements HttpService {
  late Dio _dio;

  @override
  Future<Response> getRequest(String url) async {
    Response response;
    try {
      await initilize();
      response = await _dio.get(url);
    } catch (dioError) {
      rethrow;
    }

    return response;
  }

  @override
  Future<Response> delete(String url) async {
    Response response;
    try {
      await initilize();
      response = await _dio.delete(url);
    } catch (dioError) {
      rethrow;
    }

    return response;
  }

  @override
  Future<Response> post(String url, dynamic data) async {
    Response response;
    try {
      await initilize();
      response = await _dio.post(url, data: data);
    } catch (dioError) {
      rethrow;
    }

    return response;
  }

  initilize() async {
    var prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      _dio = Dio(BaseOptions(
        baseUrl: BASE_URL,
      ));
      _dio.options.contentType = 'application/json';
    } else {
      _dio = Dio(BaseOptions(
          baseUrl: BASE_URL, headers: {"Authorization": "Bearer $token"}));
      _dio.options.contentType = 'application/json';
    }
    return true;
  }
}
