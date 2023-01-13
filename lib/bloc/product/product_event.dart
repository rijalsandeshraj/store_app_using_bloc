part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  final Product product;

  const ProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class IncreaseQuantityEvent extends ProductEvent {
  const IncreaseQuantityEvent(Product product) : super(product);
}

class DecreaseQuantityEvent extends ProductEvent {
  const DecreaseQuantityEvent(Product product) : super(product);
}

class RemoveItemEvent extends ProductEvent {
  const RemoveItemEvent(Product product) : super(product);
}

class AddToCartEvent extends ProductEvent {
  const AddToCartEvent(Product product) : super(product);
}

class FavoriteItemEvent extends ProductEvent {
  const FavoriteItemEvent(Product product) : super(product);
}
