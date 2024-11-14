import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/colors_app.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_product_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/product_model.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/controller/home_controller.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? orderProduct;

  const DeliveryProductTile({
    super.key,
    required this.product,
    required this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();

        final orderProductResult = await Navigator.of(context).pushNamed(
          '/productDetail',
          arguments: {
            'product': product,
            'order': orderProduct,
          },
        );

        if (orderProductResult != null) {
          controller.addOrUpdateBag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.name,
                      style: TextStyles.textExtraBold.copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.description,
                      style: TextStyles.textLight.copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.price.currencyPTBR,
                      style: TextStyles.textLight.copyWith(
                        fontSize: 11,
                        color: ColorsApp.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: product.image,
              width: 80,
              fit: BoxFit.contain,
            )
          ],
        ),
      ),
    );
  }
}
