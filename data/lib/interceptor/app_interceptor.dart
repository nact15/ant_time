import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data/exceptions/exceptions.dart';
import 'package:data/helpers/check_connection.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/secure_storage_repository.dart';

class AppInterceptor extends Interceptor {
  final SharedPreferencesRepository _secureStorageRepository;

  AppInterceptor({
    required SharedPreferencesRepository secureStorageRepository,
  }) : _secureStorageRepository = secureStorageRepository;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _secureStorageRepository.getApiToken();

    if (await CheckConnection.hasConnection()) {
      if (token?.isNotEmpty ?? false) {
        options.headers = {
          'X-Redmine-API-Key': token,
          'accept': 'application/json',
        };
      }
      super.onRequest(options, handler);
    } else {
      handler.reject(NoInternetConnection(requestOptions: options));
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.response?.statusCode) {
      case 400:
        handler.reject(BadRequest(requestOptions: err.requestOptions));
        break;
      case 401:
        handler.reject(Unauthorized(requestOptions: err.requestOptions));
        break;
      case 404:
        handler.reject(NotFound(requestOptions: err.requestOptions));
        break;
      case 500:
      case 502:
        handler.reject(ServerUnavailable(requestOptions: err.requestOptions));
        break;
      case 503:
        handler.reject(ServiceTemporarilyUnavailable(requestOptions: err.requestOptions));
        break;
      default:
        handler.reject(UnknownError(requestOptions: err.requestOptions));
    }
  }
}
