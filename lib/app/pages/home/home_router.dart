import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/controller/home_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/home_page.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/products_repository.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/products_repository_impl.dart';

class HomeRouter {
  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => HomeController(
              context.read(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
