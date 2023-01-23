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
    on<AddToCartEvent>(_addToCart);
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

  void _addToCart(AddToCartEvent event, Emitter<AllProductsState> emit) {
    final state = this.state;

    if (state is AllProductsLoadedState) {
      int index = state.productList!.indexOf(event.product);

      final List<Product> cartProducts = state.productList!.map((element) {
        if (element.id == event.product.id) {
          return state.productList![index].copyWith(addedToCart: true);
        }
        return element;
      }).toList();

      emit(AllProductsLoadedState(productList: cartProducts));
    }
  }
}
