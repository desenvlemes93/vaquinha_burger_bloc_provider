import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/exception/unauthorized_exceptions.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/login/controller/login_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/auth/auth_repository.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginController(this.authRepository) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await authRepository.login(
        email,
        password,
      );

      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', authModel.accessToken);
      sp.setString('refreshToken', authModel.refreshToken);

      emit(
        state.copyWith(status: LoginStatus.success),
      );
    } on UnauthorizedExceptions catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.loginError,
            messageError: 'Email ou senha invalidos'),
      );
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.error, messageError: 'Erro ao realizar Login'));
    }
  }
}
