part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  final List<Product>? productList;

  const ProductState({
    this.productList,
  });

  @override
  List<Object?> get props => [productList];

  ProductState copyWith({
    List<Product>? productList,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
    );
  }

  @override
  String toString() {
    return 'ProductState{productList: $productList}';
  }
}
