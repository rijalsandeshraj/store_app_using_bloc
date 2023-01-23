part of 'all_products_bloc.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();
}

class GetAllProductsEvent extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends AllProductsEvent {
  const AddToCartEvent(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}
