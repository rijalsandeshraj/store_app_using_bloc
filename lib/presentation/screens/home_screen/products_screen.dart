import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store_app_using_bloc/core/utils/show_custom_snack_bar.dart';

import '../../../bloc/all_products/all_products_bloc.dart';
import '../../../data/models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllProductsBloc>(context).add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state is AllProductsLoadingState) {
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Lottie.asset('assets/animations/loading.json')));
          } else if (state is AllProductsLoadedState) {
            List<Product> productsList = state.productList!;
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
              ),
              itemCount: productsList.length,
              itemBuilder: (_, index) {
                Product product = productsList[index];
                return InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Text(product.title!)],
                  ),
                );
              },
            );
          } else if (state is AllProductsErrorState) {
            showCustomSnackBar(context, state.error);
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Lottie.asset('assets/animations/loading.json')));
          } else {
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Lottie.asset('assets/animations/loading.json')));
          }
        },
      ),
    );
  }
}
