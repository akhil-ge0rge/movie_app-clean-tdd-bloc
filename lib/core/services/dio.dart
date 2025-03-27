import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/errors/exception.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppUrl.baseURL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging & error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getAuthToken(); // Fetch token dynamically
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('➡️ Request: ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          print('Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          print('❌ Error: ${error.response?.statusCode} ${error.message}');
          _handleDioError(error);
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio; // Expose Dio instance

  /// Fetch Auth Token (Replace with actual token fetching logic)
  Future<String> _getAuthToken() async {
    // Fetch token from secure storage or authentication provider
    return 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNDBkOThjMjhkNDQwODAzYTI3NjM1NjU0MzI1MDE2NCIsIm5iZiI6MTY0ODM2NDMxNS41NjksInN1YiI6IjYyNDAwYjFiOTQ1MWU3MDA4YzhkOGUwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1fPWTlRTLa3tAGAJsv12DcYv-QwLFlXMWsr1NUfzYpo'; // Replace this with actual logic
  }

  /// Custom Error Handling
  Never _handleDioError(DioException error) {
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          throw ServerException(message: "Bad Request", statusCode: 400);
        case 401:
          throw ServerException(message: "Unauthorized", statusCode: 401);
        case 403:
          throw ServerException(message: "Forbidden", statusCode: 403);
        case 404:
          throw ServerException(message: "Not Found", statusCode: 404);
        case 500:
          throw ServerException(
            message: "Internal Server Error",
            statusCode: 500,
          );
        default:
          throw ServerException(
            message: "Something went wrong",
            statusCode: error.response!.statusCode ?? 500,
          );
      }
    } else {
      throw ServerException(message: "Network error", statusCode: 500);
    }
  }

  /// Generic GET request
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } on DioException catch (e) {
      log(e.toString());
      _handleDioError(e);
    }
  }

  /// Generic POST request
  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  /// Generic PUT request
  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  /// Generic DELETE request
  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }
}
