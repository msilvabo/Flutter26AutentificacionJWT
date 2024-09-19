import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/repositories/product_repository.dart';
import 'package:teslo_shop/features/products/infraestructure/datasources/products_datasource_impl.dart';
import 'package:teslo_shop/features/products/infraestructure/repositories/product_repository_impl.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final accessToken = ref.read(authProvider).user?.token ?? '';
  final productsRepository =
      ProductRepositoryImpl(ProductsDataSourceImpl(accessToken: accessToken));
  return productsRepository;
});
