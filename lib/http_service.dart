import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpService {
  late Dio _dio;

  HttpService(String baseUrl, {String? token}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: token != null
          ? {
              "Authorization": "Bearer $token",
              "Access-Control-Allow-Origin": "*",
            }
          : {
              "Access-Control-Allow-Origin": "*",
            },
    ));

    initializeInterceptors();
  }

  Future<Response> _request(String path, {required String method, Map<String, dynamic>? query}) async {
    Response response;
    try {
      response = await _dio.request(
        path,
        options: Options(method: method),
        queryParameters: query,
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    return _request(path, method: 'get', query: query);
  }

  Future<Response> put(String path, {Map<String, dynamic>? query}) async {
    return _request(path, method: 'put', query: query);
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print("${options.method} ${options.path}");
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}
