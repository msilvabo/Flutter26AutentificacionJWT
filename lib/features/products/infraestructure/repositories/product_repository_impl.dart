import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductRepositoryImpl implements ProductRepository {
  
  final ProductDatasource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return datasource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductsById({required String id}) {
    return datasource.getProductsById(id: id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTerm({required String term}) {
    return searchProductByTerm(term: term);
  }
}
