part of 'all_products_bloc.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();
}

class GetAllProductsEvent extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends AllProductsEvent {
  const AddToCartEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class AddToFavoritesEvent extends AllProductsEvent {
  const AddToFavoritesEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class RemoveFromFavoritesEvent extends AllProductsEvent {
  const RemoveFromFavoritesEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class IncreaseQuantityEvent extends AllProductsEvent {
  const IncreaseQuantityEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class DecreaseQuantityEvent extends AllProductsEvent {
  const DecreaseQuantityEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
