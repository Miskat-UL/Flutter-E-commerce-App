import 'package:amazon_clone/constans/global_variables.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OrderState extends StatefulWidget {
  const OrderState({super.key});

  @override
  State<OrderState> createState() => _OrderState();
}

class _OrderState extends State<OrderState> {
  List list = [
    'https://www.apple.com/newsroom/images/product/mac/standard/Apple-MacBook-Air-M2-availability-July-2022-hero_big.jpg.large.jpg',
    'https://i.gadgets360cdn.com/products/large/Apple-macbook-pro-13-inch-db-1241x800-1588597842.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SingleProduct(image: list[index]);
            },
          ),
        ),
      ],
    );
  }
}
