import 'package:teslo_shop/features/products/domain/entities/product.dart';

abstract class ProductDatasource {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Product> getProductsById({required String id});
  Future<List<Product>> searchProductByTerm({required String term});
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
