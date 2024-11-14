// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/rest_client/custom_dio.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/exception/repository_exception.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/exception/unauthorized_exceptions.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/auth_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio customDio;
  AuthRepositoryImpl({
    required this.customDio,
  });
  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final Response(:data) = await customDio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromMap(data);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == HttpStatus.forbidden) {
        log('Sem permissão de acesso', error: e, stackTrace: s);
        throw UnauthorizedExceptions();
      }
      log('Erro ao realizar login ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar Login');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await customDio.unauth().post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioException catch (e, s) {
      log('Erro ao inserir usuario', error: e, stackTrace: s);
      throw RepositoryException(
        message: 'Erro ao cadastrar usuario',
      );
    }
  }
}
