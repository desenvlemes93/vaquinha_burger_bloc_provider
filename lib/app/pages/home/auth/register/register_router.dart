import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/register/controller/register_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/register/register_page.dart';

sealed class RegisterRouter {
  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => RegisterController(
              context.read(),
            ),
          ),
        ],
        child: const RegisterPage(),
      );
}
