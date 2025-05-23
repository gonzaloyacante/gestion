import 'package:dio/dio.dart';
import '../config/app_config.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= Dio(
        BaseOptions(
          baseUrl: AppConfig.apiUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          validateStatus: (status) {
            return status != null && status < 500;
          },
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      )
      ..interceptors.addAll([
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (object) => print('Dio Log: $object'),
        ),
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print('Sending request to ${options.uri}');
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print('Received response from ${response.requestOptions.uri}');
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            print('Error in request to ${e.requestOptions.uri}: ${e.message}');
            return handler.next(e);
          },
        ),
      ]);

    return _dio!;
  }
}
