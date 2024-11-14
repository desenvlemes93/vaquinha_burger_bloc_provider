import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/order_page.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/controller/order_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/order/order_repository.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/order/order_repository_impl.dart';

sealed class OrderRouter {
  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(dio: context.read()),
          ),
          Provider(create: (context) => OrderController(context.read())),
        ],
        child: const OrderPage(),
      );
}
