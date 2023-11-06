import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/models/subscription_info.dart';
import 'package:flutter_women_workout_ui/util/color_category.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../util/constants.dart';

class SubscriptionInfoCard extends StatelessWidget {
  final SubscriptionInfo subscriptionInfo;
  SubscriptionInfoCard({super.key, required this.subscriptionInfo});
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subscriptionInfo.packageName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontFamily: Constants.fontsFamily),
              ),
              Text(
                "${subscriptionInfo.amount}EGP",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: accentColor, fontFamily: Constants.fontsFamily),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            subscriptionInfo.packageDuration,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontFamily: Constants.fontsFamily),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Started At".tr + ":",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontFamily: Constants.fontsFamily),
              ),
              Text(
                "${formatter.format(subscriptionInfo.startSubscribe)}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: accentColor, fontFamily: Constants.fontsFamily),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "End At".tr + ":",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontFamily: Constants.fontsFamily),
              ),
              Text(
                "${formatter.format(subscriptionInfo.endSubscribe)}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: accentColor, fontFamily: Constants.fontsFamily),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
