import 'package:vaquinha_burger_provider_bloc/app/models/auth_model.dart';

abstract interface class AuthRepository {
  Future<AuthModel> login(String email, String password);
  Future<void> register(String name, String email, String password);
}
