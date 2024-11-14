import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_product_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/controller/home_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/products_repository.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productRepository;

  HomeController(
    this._productRepository,
  ) : super(const HomeState.initial());

  Future<void> loadProduct() async {
    try {
      emit(state.copyWith(status: HomeStateStatus.loading));
      final product = await _productRepository.findAllProducts();
      emit(
        state.copyWith(
          status: HomeStateStatus.loaded,
          products: product,
        ),
      );
    } catch (e, s) {
      log('Erro ao buscar produto', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao Buscar produtos',
        ),
      );
    }
  }

  void addOrUpdateBag(OrderProductDto orderProductResult) {
    final shoppingBag = [...state.shoppingBag];

    final shoppingBagIndex = shoppingBag
        .indexWhere((orderP) => orderP.product == orderProductResult.product);

    if (shoppingBagIndex > -1) {
      shoppingBag[shoppingBagIndex] = orderProductResult;

      if (orderProductResult.amount == 0) {
        shoppingBag.removeAt(shoppingBagIndex);
      }
    } else {
      shoppingBag.add(orderProductResult);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updateBag(List<OrderProductDto> updateBag) {
    emit(state.copyWith(shoppingBag: updateBag));
  }
}
