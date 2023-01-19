import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/product_categories.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/category.dart';

String productCategoryTitle = 'All';

class ProductCategoriesWidget extends StatefulWidget {
  const ProductCategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCategoriesWidget> createState() =>
      _ProductCategoriesWidgetState();
}

class _ProductCategoriesWidgetState extends State<ProductCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          Category productCategory = productCategories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                productCategoryTitle = productCategory.title;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.white,
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    productCategory.iconData,
                    color: productCategoryTitle == productCategory.title
                        ? AppColor.primaryPink
                        : AppColor.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    productCategory.title,
                    style: productCategoryTitle == productCategory.title
                        ? selectedCategoryTextStyle
                        : secondaryTextStyle,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
