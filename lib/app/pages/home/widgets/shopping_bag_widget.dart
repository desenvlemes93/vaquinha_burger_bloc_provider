import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/helpers/size_extensions.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_product_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/controller/home_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/order_page.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;
  const ShoppingBagWidget({
    super.key,
    required this.bag,
  });

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();

    if (!sp.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed('/auth/login');
      if (loginResult == false || loginResult == null) {
        return;
      }
    }
    final updateBag = await navigator.pushNamed(
      '/order',
      arguments: bag,
    );

    controller.updateBag(updateBag as List<OrderProductDto>);
  }

  @override
  Widget build(BuildContext context) {
    var totalBag = bag
        .fold<double>(0.0, (total, element) => total += element.totalPrice)
        .currencyPTBR;
    return Container(
      padding: const EdgeInsets.all(20),
      width: context.screenWidth,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: ElevatedButton(
          onPressed: () {
            _goOrder(context);
          },
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.shopping_cart_outlined),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Ver Sacola',
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  totalBag,
                  style: TextStyles.textExtraBold.copyWith(fontSize: 11),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
