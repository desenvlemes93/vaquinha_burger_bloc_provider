// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/colors_app.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_product_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/controller/order_controller.dart';

class OrderProductTitle extends StatelessWidget {
  final int index;
  final OrderProductDto orderProduct;

  const OrderProductTitle({
    super.key,
    required this.index,
    required this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          orderProduct.product.image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderProduct.product.name,
                  style: TextStyles.textRegular.copyWith(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (orderProduct.amount * orderProduct.product.price)
                          .currencyPTBR,
                      style: TextStyles.textMedium
                          .copyWith(fontSize: 14, color: ColorsApp.secondary),
                    ),
                    DeliveryIncrementDecrementButton.compact(
                      amount: orderProduct.amount,
                      incrementTap: () {
                        context
                            .read<OrderController>()
                            .incrementOrderProduct(index);
                      },
                      decrementTap: () {
                        context
                            .read<OrderController>()
                            .decrementOrderProduct(index);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
