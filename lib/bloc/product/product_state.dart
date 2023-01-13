part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  final List<Product> productList;

  const ProductState({
    required this.productList,
  });

  const ProductState.initial(List<Product> productList)
      : this(productList: productList);

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
