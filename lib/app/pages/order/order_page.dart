import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/base_state/base_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_button.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_product_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/payments_types_model.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/controller/order_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/controller/order_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/order_field.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/order_product_title.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/payment_types_field.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final _formKey = GlobalKey<FormState>();
  final _addressEC = TextEditingController();
  final _documentsEC = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onRead() {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  @override
  void dispose() {
    _addressEC.dispose();
    _documentsEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage ?? 'Erro não informado');
          },
          confirmRemoveProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmProductDialog(state);
            }
          },
          emptyBag: () {
            showInfo(
              'Sua sacola está vazia, por favor selecione um produto para realizar um pedido',
            );
            Navigator.pop(context, <OrderProductDto>[]);
          },
          success: () {
            hideLoader();
            Navigator.of(context).popAndPushNamed('/order/completed',
                result: <OrderProductDto>[]);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Carrinho',
                        style: TextStyles.textTile,
                      ),
                      IconButton(
                        onPressed: () => controller.emptyBag(),
                        icon: Image.asset('assets/images/trashRegular.png'),
                      ),
                    ],
                  ),
                ),
              ),
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
                selector: (state) => state.orderProducts,
                builder: (context, orderProducts) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: orderProducts.length,
                      (context, index) {
                        final orderProduct = orderProducts[index];
                        return Column(
                          children: [
                            OrderProductTitle(
                              index: index,
                              orderProduct: orderProduct,
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total dos pedidos',
                            style: TextStyles.textExtraBold.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          BlocSelector<OrderController, OrderState, double>(
                            selector: (state) => state.totalOrder,
                            builder: (context, totalOrder) {
                              return Text(
                                totalOrder.currencyPTBR,
                                style: TextStyles.textExtraBold
                                    .copyWith(fontSize: 20),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderField(
                      title: 'Endereço de Entrega',
                      controller: _addressEC,
                      validator: Validatorless.required('Endereço obrigatório'),
                      hintText: 'Digite um endereço',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderField(
                      title: 'CPF',
                      controller: _documentsEC,
                      validator: Validatorless.required('CPF obrigatório'),
                      hintText: 'Digite o CPF',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocSelector<OrderController, OrderState,
                        List<PaymentsTypesModel>>(
                      selector: (state) => state.paymentypes,
                      builder: (context, paymentTypes) {
                        return ValueListenableBuilder(
                          valueListenable: paymentTypeValid,
                          builder: (_, paymentTypeValid, child) {
                            return PaymentTypesField(
                              valueChanged: (value) {
                                paymentTypeId = value;
                              },
                              valid: paymentTypeValid,
                              valueSelected: paymentTypeId.toString(),
                              paymentTypes: paymentTypes,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DeliveryButton(
                        width: double.infinity,
                        height: 48,
                        label: 'FINALIZAR',
                        onPressed: () {
                          var valid =
                              _formKey.currentState?.validate() ?? false;
                          final paymentTypeSelected = paymentTypeId != null;
                          paymentTypeValid.value = paymentTypeSelected;

                          if (valid) {
                            controller.saveOrder(
                              address: _addressEC.text,
                              document: _documentsEC.text,
                              paymentMethodId: paymentTypeId!,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Deseja excluir o produto ${state.orderProduct.product.name} ? '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.cancelDeleteProcess();
              },
              child: Text(
                'Cancelar',
                style: TextStyles.textBold.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.decrementOrderProduct(state.index);
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
}
