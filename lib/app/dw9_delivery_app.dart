import 'package:flutter/material.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/global/global_context.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/provider/application_binding.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/theme/theme_config.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/login/login_router.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/register/register_router.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/home_router.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/completed_page.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/order_router.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/product_detail/product_detail_router.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/splash/splash_page.dart';

class Dw9DeliveryApp extends StatelessWidget {
  final _naviKey = GlobalKey<NavigatorState>();
  Dw9DeliveryApp({super.key}) {
    GlobalContext.i.navigatorKey = _naviKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        theme: ThemeConfig.theme,
        navigatorKey: _naviKey,
        title: 'Delivery App',
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const CompletedPage()
        },
      ),
    );
  }
}
