import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/rest_client/custom_dio.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/exception/repository_exception.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/product_model.dart';
import 'package:vaquinha_burger_provider_bloc/app/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio dio;

  ProductsRepositoryImpl({
    required this.dio,
  });
  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final Response(:List data) = await dio.unauth().get('/products');
      
      return data.map((product) => ProductModel.fromMap(product)).toList();
    } on DioException {
      log('Erro ao buscar produto');
      throw RepositoryException(message: 'Erro ao buscar Produto');
      // TODO
    }
  }
}
