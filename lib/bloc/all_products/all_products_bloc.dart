import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:store_app_using_bloc/data/store_repository.dart';

import '../../data/models/product.dart';

part 'all_products_event.dart';

part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsLoadingState()) {
    on<GetAllProductsEvent>(_getAllProducts);
    on<AddToFavoritesEvent>(_addToFavorites);
    on<RemoveFromFavoritesEvent>(_removeFromFavorites);
    on<AddToCartEvent>(_addToCart);
    on<IncreaseQuantityEvent>(_increaseQuantity);
    on<DecreaseQuantityEvent>(_decreaseQuantity);
    on<RemoveFromCartEvent>(_removeFromCart);
  }

  void _getAllProducts(
      GetAllProductsEvent event, Emitter<AllProductsState> emit) async {
    emit(AllProductsLoadingState());
    StoreRepository repository = StoreRepository();
    try {
      await repository.getAllProducts();
      emit(AllProductsLoadedState(productList: repository.allProducts));
    } catch (e) {
      emit(AllProductsErrorState(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void _addToFavorites(
      AddToFavoritesEvent event, Emitter<AllProductsState> emit) {
    final state = this.state;

    if (state is AllProductsLoadedState) {
      final List<Product> products = state.productList!.map((element) {
        if (element.id == event.id) {
          element = element.copyWith(isFavorite: true);
        }
        return element;
      }).toList();

      emit(state.copyWith(productList: products));
    }
  }

  void _removeFromFavorites(
      RemoveFromFavoritesEvent event, Emitter<AllProductsState> emit) {
    final state = this.state;

    if (state is AllProductsLoadedState) {
      final List<Product> products = state.productList!.map((element) {
        if (element.id == event.id) {
          element = element.copyWith(isFavorite: false);
        }
        return element;
      }).toList();

      emit(state.copyWith(productList: products));
    }
  }

  void _addToCart(AddToCartEvent event, Emitter<AllProductsState> emit) {
    final state = this.state;

    if (state is AllProductsLoadedState) {
      final List<Product> products = state.productList!.map((element) {
        if (element.id == event.id) {
          element = element.copyWith(addedToCart: true);
        }
        return element;
      }).toList();

      emit(state.copyWith(productList: products));
    }
  }

  void _increaseQuantity(
      IncreaseQuantityEvent event, Emitter<AllProductsState> emit) {
    final state = this.state;

    if (state is AllProductsLoadedState) {
      int quantity = state.productList!
          .firstWhere((element) => element.id == event.id)
          .quantity;
      final List<Product> products = state.productList!.map((element) {
        if (element.id == event.id) {
          element = element.copyWith(quantity: quantity + 1);
        }
        return element;
      }).toList();

      emit(state.copyWith(productList: products));
    }
  }

  void _decreaseQuantity(
      DecreaseQuantityEvent event, Emitter<AllProductsState> emit) {
    final state = this.state;

    if (state is AllProductsLoadedState) {
      int quantity = state.productList!
          .firstWhere((element) => element.id == event.id)
          .quantity;
      final List<Product> products = state.productList!.map((element) {
        if (element.id == event.id) {
          element = element.copyWith(quantity: quantity - 1);
        }
        return element;
      }).toList();

      emit(state.copyWith(productList: products));
    }
  }

  void _removeFromCart(
      RemoveFromCartEvent event, Emitter<AllProductsState> emit) {
    final state = this.state;

    if (state is AllProductsLoadedState) {
      final List<Product> products = state.productList!.map((element) {
        if (element.id == event.id) {
          element = element.copyWith(addedToCart: false);
        }
        return element;
      }).toList();

      emit(state.copyWith(productList: products));
    }
  }

  double get getTotalPrice {
    double totalPrice = 5;
    List<Product> cartProducts = getCartProducts;

    for (var element in cartProducts) {
      totalPrice += element.quantity * element.price!;
    }

    return totalPrice;
  }

  get getCartProducts {
    final state = this.state;
    if (state is AllProductsLoadedState) {
      List<Product> cartProducts =
          state.productList!.where((element) => element.addedToCart).toList();
      return cartProducts;
    }
    return <Product>[];
  }

  get getFavoriteProducts {
    final state = this.state;
    if (state is AllProductsLoadedState) {
      List<Product> favoriteProducts =
          state.productList!.where((element) => element.isFavorite).toList();
      return favoriteProducts;
    }
    return <Product>[];
  }
}
