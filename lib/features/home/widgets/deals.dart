import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Deal of the day',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Image.network(
          'https://fdn2.gsmarena.com/vv/pics/google/google-pixel-4a-3.jpg',
          height: 200,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            '\$400',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            top: 5,
            left: 15,
            right: 40,
          ),
          child: const Text(
            'Google Pixel 4a',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://fdn2.gsmarena.com/vv/pics/google/google-pixel-4a-3.jpg',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                'https://fdn2.gsmarena.com/vv/pics/google/google-pixel-4a-3.jpg',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                'https://fdn2.gsmarena.com/vv/pics/google/google-pixel-4a-3.jpg',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                'https://fdn2.gsmarena.com/vv/pics/google/google-pixel-4a-3.jpg',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            'See All Deals',
            style: TextStyle(color: Colors.cyan[800]),
          ),
        ),
      ],
    );
  }
}
