// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:vaquinha_burger_provider_bloc/app/models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;

  OrderProductDto({
    required this.product,
    required this.amount,
  });

  double get totalPrice => amount * product.price;

  @override
  String toString() => 'OrderProductDto(product: $product, amount: $amount)';

  OrderProductDto copyWith({
    ProductModel? product,
    int? amount,
  }) {
    return OrderProductDto(
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }
}
