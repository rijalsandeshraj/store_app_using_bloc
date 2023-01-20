part of 'all_products_bloc.dart';

@immutable
abstract class AllProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllProductsLoadingState extends AllProductsState {
  @override
  List<Object?> get props => [];
}

class AllProductsLoadedState extends AllProductsState {
  final List<Product>? productList;

  AllProductsLoadedState({
    this.productList,
  });

  @override
  List<Object?> get props => [productList];

  AllProductsLoadedState copyWith({
    List<Product>? productList,
  }) {
    return AllProductsLoadedState(
      productList: productList ?? this.productList,
    );
  }

  @override
  String toString() {
    return 'AllProductsLoadedState{productList: $productList}';
  }
}

class AllProductsErrorState extends AllProductsState {
  final String error;

  AllProductsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
