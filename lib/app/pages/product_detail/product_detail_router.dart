import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/product_detail/controller/product_controller_button_increment_decrement.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/product_detail/product_detail_page.dart';

class ProductDetailRouter {
  static Widget get page => MultiProvider(
        providers: [
          Provider(
              create: (context) => ProductControllerButtonIncrementDecrement())
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ProductDetailPage(
            product: args['product'],
            order: args['order'],
          );
        },
      );
}
