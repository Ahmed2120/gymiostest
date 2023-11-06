import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/util/color_category.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/subscriptions_provider.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/widgets/package_list_item.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/widgets/subscription_info_card.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../../util/constants.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Subscriptions".tr,
          style: TextStyle(
              color: Colors.black,
              fontFamily: Constants.fontsFamily,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<SubscriptionsProvider>(
        builder: (context, value, child) => value.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : value.isSubscribed
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subscription Details".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Constants.fontsFamily),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SubscriptionInfoCard(
                            subscriptionInfo: value.subscriptionInfo!),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor),
                              onPressed: () {
                                Get.toNamed(Routes.subscriptionHistoryRoute,
                                    arguments: value.subscriptions);
                              },
                              child: Text(
                                "Subscriptions History".tr.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Constants.fontsFamily,
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: value.packages.length,
                    itemBuilder: (context, index) =>
                        PackageListItem(package: value.packages[index]),
                  ),
      ),
    );
  }
}
