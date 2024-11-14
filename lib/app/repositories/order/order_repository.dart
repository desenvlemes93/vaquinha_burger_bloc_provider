import 'package:vaquinha_burger_provider_bloc/app/dto/order_dto.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/payments_types_model.dart';

abstract class OrderRepository {
  Future<List<PaymentsTypesModel>> getAllPaymentsTypes();
  Future<void> saveOrder(OrderDto orderDto);
}
