import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_product_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/order/widget/controller/order_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/order/order_repository.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderController(this.orderRepository) : super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentTypes = await orderRepository.getAllPaymentsTypes();
      emit(
        state.copyWith(
          orderProducts: products,
          paymentypes: paymentTypes,
          status: OrderStatus.loaded,
        ),
      );
    } catch (e, s) {
      log('Erro ao buscar Pagamentos');
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: 'Erro ao Buscar Pagamentos',
      ));
      // TODO
    }
  }

  void incrementOrderProduct(int index) {
    final orders = [...state.orderProducts];

    final order = orders[index];

    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(state.copyWith(
      orderProducts: orders,
      status: OrderStatus.upateOrder,
    ));
  }

  void decrementOrderProduct(int index) {
    final orders = [...state.orderProducts];

    final order = orders[index];
    final amount = order.amount;

    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(OrderConfirmDeleteProductState(
          orderProduct: order,
          index: index,
          status: OrderStatus.confirmRemoveProduct,
          orderProducts: state.orderProducts,
          paymentypes: state.paymentypes,
          errorMessage: state.errorMessage,
        ));
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }
    emit(state.copyWith(
      orderProducts: orders,
      status: OrderStatus.upateOrder,
    ));

    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }
  }

  void cancelDeleteProcess() {
    emit(
      state.copyWith(
        status: OrderStatus.loaded,
      ),
    );
  }

  void emptyBag() {
    emit(
      state.copyWith(
        status: OrderStatus.emptyBag,
      ),
    );
  }

  void saveOrder(
      {required String address,
      required String document,
      required int paymentMethodId}) async {
    emit(state.copyWith(status: OrderStatus.loading));

    await orderRepository.saveOrder(OrderDto(
        products: state.orderProducts,
        address: address,
        document: document,
        paymentMethodId: paymentMethodId));

    emit(state.copyWith(status: OrderStatus.success));
  }
}
