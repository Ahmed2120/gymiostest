// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_women_workout_ui/models/package.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../util/color_category.dart';
import '../../checkout/cart_checkout_screen.dart';

class PackageListItem extends StatelessWidget {
  const PackageListItem({
    Key? key,
    required this.package,
  }) : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed(Routes.checkoutRoute, arguments: package);
        // Get.toNamed(Routes.cartCheckoutRoute, arguments: package);
        Get.toNamed(Routes.appleCheckoutRoute, arguments: package);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> CartCheckoutScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: accentColor, width: 2),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  package.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(
                      "${package.price}EGP",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: accentColor),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      package.duration,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
