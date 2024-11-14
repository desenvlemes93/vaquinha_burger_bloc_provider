import 'package:vaquinha_burger_provider_bloc/app/models/product_model.dart';
abstract class ProductsRepository {
  Future<List<ProductModel>> findAllProducts();

}