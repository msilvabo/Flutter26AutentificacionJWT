import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_provider.dart';
// import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';

import '../../../../shared/infrastructure/inputs/inputs.dart';

//PROVIDER

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  // final createUpdateCallback =
  //     ref.watch(productRepositoryProvider).createUpdateProduct;
  final createUpdateCallback =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;

  return ProductFormNotifier(
      product: product, onSubmilCallback: createUpdateCallback);
});

// NOTIFIER

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(Map<String, dynamic> productLike)?
      onSubmilCallback;

  ProductFormNotifier({this.onSubmilCallback, required Product product})
      : super(ProductFormState(
          id: product.id,
          tittle: Tittle.dirty(product.title),
          slug: Slug.dirty(product.slug),
          price: Price.dirty(product.price),
          inStock: Stock.dirty(product.stock),
          sizes: product.sizes,
          gender: product.gender,
          description: product.description,
          tags: product.tags.join(', '),
          images: product.images,
        ));

  Future<bool> onFormSubmit() async {
    _touchEverything();
    if (!state.isFormValid) return false;

    if (onSubmilCallback == null) return false;

    final productLike = {
      "id": (state.id == 'new') ? null : state.id,
      "title": state.tittle.value,
      "price": state.price.value,
      "description": state.description,
      "slug": state.slug.value,
      "stock": state.inStock.value,
      "sizes": state.sizes,
      "gender": state.gender,
      "tags": state.tags.split(','),
      "images": state.images
          .map((image) =>
              image.replaceAll('${Enviroment.apiURL}/files/product/', ''))
          .toList()
    };
    try {
      return await onSubmilCallback!(productLike);
    } catch (e) {
      return false;
    }
  }

  void _touchEverything() {
    state = state.copyWith(
        isFormValid: Formz.validate([
      Tittle.dirty(state.tittle.value),
      Slug.dirty(state.slug.value),
      Price.dirty(state.price.value),
      Stock.dirty(state.inStock.value),
    ]));
  }

  void onTitleChange(String value) {
    state = state.copyWith(
        tittle: Tittle.dirty(value),
        isFormValid: Formz.validate([
          Tittle.dirty(value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onSlugChange(String value) {
    state = state.copyWith(
        slug: Slug.dirty(value),
        isFormValid: Formz.validate([
          Tittle.dirty(state.tittle.value),
          Slug.dirty(value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onPriceChange(double value) {
    state = state.copyWith(
        price: Price.dirty(value),
        isFormValid: Formz.validate([
          Tittle.dirty(state.tittle.value),
          Slug.dirty(state.slug.value),
          Price.dirty(value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onStockChange(int value) {
    state = state.copyWith(
        inStock: Stock.dirty(value),
        isFormValid: Formz.validate([
          Tittle.dirty(state.tittle.value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(value),
        ]));
  }

  void onSizesChange(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChange(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChange(String description) {
    state = state.copyWith(description: description);
  }

  void onTagChange(String tags) {
    state = state.copyWith(tags: tags);
  }

  void updateProductImage(String path) {
    state = state.copyWith(
      images: [path,...state.images]
    );
  }
}

//STATE
class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Tittle tittle;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState(
      {this.isFormValid = false,
      this.id,
      this.tittle = const Tittle.dirty(''),
      this.slug = const Slug.dirty(''),
      this.price = const Price.dirty(0),
      this.sizes = const [],
      this.gender = 'men',
      this.inStock = const Stock.dirty(0),
      this.description = '',
      this.tags = '',
      this.images = const []});

  ProductFormState copyWith(
          {bool? isFormValid,
          String? id,
          Tittle? tittle,
          Slug? slug,
          Price? price,
          List<String>? sizes,
          String? gender,
          Stock? inStock,
          String? description,
          String? tags,
          List<String>? images}) =>
      ProductFormState(
          isFormValid: isFormValid ?? this.isFormValid,
          id: id ?? this.id,
          tittle: tittle ?? this.tittle,
          slug: slug ?? this.slug,
          price: price ?? this.price,
          sizes: sizes ?? this.sizes,
          gender: gender ?? this.gender,
          inStock: inStock ?? this.inStock,
          description: description ?? this.description,
          tags: tags ?? this.tags,
          images: images ?? this.images);
}
