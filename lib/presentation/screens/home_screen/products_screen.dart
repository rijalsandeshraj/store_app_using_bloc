import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../data/models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.productList == null) {
            print('if');
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Lottie.asset('assets/animations/loading.json')));
          } else {
            List<Product> productsList = state.productList!;
            setState(() {});
            print('else');
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
          }
        },
      ),
    );
  }
}
