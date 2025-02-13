import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/rest_client/custom_dio.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/auth/auth_repository.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/auth/auth_repository_impl.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            customDio: context.read(),
          ),
        ),
      ],
      child: child,
    );
  }
}
