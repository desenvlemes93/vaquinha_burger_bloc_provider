import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/register/controller/register_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterController(this._authRepository) : super(RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authRepository.register(
        name,
        email,
        password,
      );
      emit(
        state.copyWith(status: RegisterStatus.sucess),
      );
    } catch (e, s) {
      log('Erro ao registrar usuario, controller', error: e, stackTrace: s);
      emit(
        state.copyWith(status: RegisterStatus.error),
      );
    }
  }
}
