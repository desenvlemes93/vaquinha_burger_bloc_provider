import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/base_state/base_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/helpers/size_extensions.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_product_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/product_model.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/product_detail/controller/product_controller_button_increment_decrement.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.order,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BaseState<ProductDetailPage,
    ProductControllerButtonIncrementDecrement> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final amount = widget.order?.amount ?? 1;
    controller.initial(
      amount,
      widget.order != null,
    );
  }

  void _showCofirmDelete(int amount) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja excluir o produto ? '),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyles.textBold.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context);
                Navigator.of(context).pop(
                  OrderProductDto(
                    product: widget.product,
                    amount: amount,
                  ),
                );
              },
              child: Text(
                'Confirmar',
                style: TextStyles.textBold,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: context.screenWidth,
          height: context.percentHeight(.4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.product.image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            widget.product.name,
            style: TextStyles.textExtraBold.copyWith(
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                SingleChildScrollView(child: Text(widget.product.description)),
          ),
        ),
        const Divider(),
        Row(
          children: [
            Container(
                height: 68,
                padding: const EdgeInsetsDirectional.all(8),
                width: context.percentWidth(
                  .5,
                ),
                child:
                    BlocBuilder<ProductControllerButtonIncrementDecrement, int>(
                  builder: (context, amount) {
                    return DeliveryIncrementDecrementButton(
                      decrementTap: () {
                        controller.decrement();
                      },
                      incrementTap: () {
                        controller.incremement();
                      },
                      amount: amount,
                    );
                  },
                )),
            SizedBox(
              width: context.percentWidth(.5),
              height: 68,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    BlocBuilder<ProductControllerButtonIncrementDecrement, int>(
                  builder: (context, amount) {
                    return ElevatedButton(
                      style: amount == 0
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.red)
                          : null,
                      onPressed: () async {
                        if (amount == 0) {
                          _showCofirmDelete(amount);
                        } else {
                          Navigator.of(context).pop(
                            OrderProductDto(
                              product: widget.product,
                              amount: amount,
                            ),
                          );
                        }
                      },
                      child: Visibility(
                        visible: amount > 0,
                        replacement: Text(
                          'Excluir Produto',
                          style: TextStyles.textExtraBold,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Adicionar',
                              style: TextStyles.textExtraBold
                                  .copyWith(fontSize: 13),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                (widget.product.price * amount).currencyPTBR,
                                maxLines: 1,
                                maxFontSize: 13,
                                minFontSize: 5,
                                style: TextStyles.textExtraBold
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
