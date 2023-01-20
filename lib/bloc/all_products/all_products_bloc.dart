import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:store_app_using_bloc/data/store_repository.dart';

import '../../data/models/product.dart';

part 'all_products_event.dart';

part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsLoadingState()) {
    on<AllProductsEvent>(_getAllProducts);
  }

  void _getAllProducts(
      AllProductsEvent event, Emitter<AllProductsState> emit) async {
    emit(AllProductsLoadingState());
    StoreRepository repository = StoreRepository();
    try {
      final List<Product>? products = await repository.getAllProducts();
      emit(AllProductsLoadedState(productList: products));
    } catch (e) {
      emit(AllProductsErrorState(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
