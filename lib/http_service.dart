import 'package:dio/dio.dart';

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
    response = await _dio.request(
      path,
      options: Options(method: method),
      queryParameters: query,
    );

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
