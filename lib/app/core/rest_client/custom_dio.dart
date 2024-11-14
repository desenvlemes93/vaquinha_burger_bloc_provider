import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/config/env/env.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/rest_client/interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  late AuthInterceptor _authInterceptor;

  CustomDio()
      : super(BaseOptions(
          baseUrl: Env.baseII,
          connectTimeout: const Duration(seconds: 5000),
          receiveTimeout: const Duration(seconds: 60000),
        )) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
    _authInterceptor = AuthInterceptor(this);
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
