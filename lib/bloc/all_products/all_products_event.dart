part of 'all_products_bloc.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();
}

class GetAllProductsEvent extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}
