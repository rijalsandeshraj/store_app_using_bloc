import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:store_app_using_bloc/data/store_repository.dart';

import '../../data/models/product.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends HydratedBloc<ProductEvent, ProductState> {
  ProductBloc({required this.repository})
      : super(ProductState.initial(repository.allProducts)) {
    on<IncreaseQuantityEvent>(_increaseQuantity);
    on<DecreaseQuantityEvent>(_decreaseQuantity);
    on<RemoveItemEvent>(_removeItem);
    on<FavoriteItemEvent>(_isFavorite);
    on<AddToCartEvent>(_addToCart);
  }

  final StoreRepository repository;

  void _increaseQuantity(
      IncreaseQuantityEvent event, Emitter<ProductState> emit) {
    int index = state.productList!.indexOf(event.product);

    final List<Product> productList = state.productList!.map((element) {
      if (element.id == event.product.id) {
        return state.productList![index]
            .copyWith(quantity: state.productList![index].quantity + 1);
      }
      return element;
    }).toList();

    emit(ProductState(productList: productList));
  }

  void _decreaseQuantity(
      DecreaseQuantityEvent event, Emitter<ProductState> emit) {
    int index = state.productList!.indexOf(event.product);

    final List<Product> productList = state.productList!.map((element) {
      if (element.id == event.product.id && element.quantity > 1) {
        return state.productList![index]
            .copyWith(quantity: state.productList![index].quantity - 1);
      }
      //for Item quantity less than zero this statement will be called
      if (element.id == event.product.id) {
        //Remove item from cart
        return state.productList![index].copyWith(addedToCart: false);
      }
      return element;
    }).toList();

    emit(ProductState(productList: productList));
  }

  void _removeItem(RemoveItemEvent event, Emitter<ProductState> emit) {
    final List<Product> productList = state.productList!.map((element) {
      if (element.id == event.product.id) {
        return event.product.copyWith(addedToCart: false);
      }
      return element;
    }).toList();

    emit(ProductState(productList: productList));
  }

  void _isFavorite(FavoriteItemEvent event, Emitter<ProductState> emit) {
    int index = state.productList!.indexOf(event.product);
    final List<Product> productList = state.productList!.map((element) {
      if (element.id == event.product.id) {
        return event.product
            .copyWith(isFavorite: !state.productList![index].isFavorite);
      }
      return element;
    }).toList();

    emit(ProductState(productList: productList));
  }

  void _addToCart(AddToCartEvent event, Emitter<ProductState> emit) {
    int index = state.productList!.indexOf(event.product);

    final List<Product> cartProduct = state.productList!.map((element) {
      if (element.id == event.product.id) {
        return state.productList![index].copyWith(addedToCart: true);
      }
      return element;
    }).toList();

    emit(ProductState(productList: cartProduct));
  }

  String pricePerEachItem(Product product) {
    double price = 0;
    price = product.quantity * product.price!.toDouble();
    return price.toString();
  }

  double get getTotalPrice {
    double totalPrice = 5;
    for (var element in state.productList!) {
      if (element.addedToCart) {
        totalPrice += element.quantity * element.price!.toDouble();
      }
    }
    return totalPrice;
  }

  get getCartList =>
      state.productList!.where((element) => element.addedToCart).toList();

  get getFavoriteList =>
      state.productList!.where((element) => element.isFavorite).toList();

  @override
  ProductState? fromJson(Map<String, dynamic> json) {
    return json['value'] as ProductState;
  }

  @override
  Map<String, dynamic>? toJson(ProductState state) {
    return {'value': state};
  }
}
