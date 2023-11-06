import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/models/subscription_info.dart';
import 'package:flutter_women_workout_ui/util/color_category.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../util/constants.dart';

class SubscriptionsHistoryScreen extends StatelessWidget {
  const SubscriptionsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subs = Get.arguments as List<SubscriptionInfo>;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Subscriptions History".tr,
          style: TextStyle(
              color: Colors.black,
              fontFamily: Constants.fontsFamily,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: subs.length,
          itemBuilder: (context, index) => ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      subs[index].packageName,
                      style: TextStyle(color: accentColor, fontSize: 18),
                    ),
                  ],
                ),
                trailing: Text(
                  subs[index].packageDuration,
                  textAlign: TextAlign.center,
                ),
                title: Text("${formatter.format(subs[index].startSubscribe)}"),
                subtitle: Text("${subs[index].amount}EGP"),
              )),
    );
  }
}
