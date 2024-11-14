import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/base_state/base_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/controller/home_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/controller/home_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/widgets/delivery_product_tile.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/widgets/shopping_bag_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onRead() {
    // TODO: implement onRead
    controller.loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError(
                state.errorMessage ?? 'Erro Não Informado',
              );
            },
          );
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          loaded: () => true,
          initial: () => true,
        ),
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    final orderss = state.shoppingBag
                        .where((order) => order.product == product);
                    return DeliveryProductTile(
                      product: product,
                      orderProduct: orderss.isNotEmpty ? orderss.first : null,
                    );
                  },
                ),
              ),
              Visibility(
                  visible: state.shoppingBag.isNotEmpty,
                  child: ShoppingBagWidget(
                    bag: state.shoppingBag,
                  )),
            ],
          );
        },
      ),
    );
  }
}
