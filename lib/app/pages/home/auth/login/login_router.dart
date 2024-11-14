import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/login/controller/login_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/login/login_page.dart';

sealed class LoginRouter {
  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => LoginController(
              context.read(),
            ),
          ),
        ],
        child: const LoginPage(),
      );
}
