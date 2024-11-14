// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/exception/repository_exception.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/rest_client/custom_dio.dart';
import 'package:vaquinha_burger_provider_bloc/app/dto/order_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/payments_types_model.dart';

import './order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final CustomDio dio;
  OrderRepositoryImpl({
    required this.dio,
  });
  @override
  Future<List<PaymentsTypesModel>> getAllPaymentsTypes() async {
    try {
      final Response(:List data) = await dio.auth().get('/payment-types');

      return data
          .map<PaymentsTypesModel>(
              (payment) => PaymentsTypesModel.fromMap(payment))
          .toList();
    } on DioException catch (e, s) {
      log(
        'Erro ao buscar formas de pagamento',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Erro ao buscar forma de Pagamento');
      // TODO
    }
  }

  @override
  Future<void> saveOrder(OrderDto orderDto) async {
    try {
      await dio.auth().post('/orders', data: {
        'products': orderDto.products
            .map((product) => {
                  'id': product.product.id,
                  'amount': product.amount,
                  'total_price': product.totalPrice
                })
            .toList(),
        'user_id': '#userAuthRef',
        'address': orderDto.address,
        'CPF': orderDto.document,
        'payment_method_id': orderDto.paymentMethodId
      });
    } on DioException catch (e, s) {
      log('Erro ao salvar Pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar pedido');
      // TODO
    }
  }
}
