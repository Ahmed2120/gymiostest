import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/models/package.dart';
import 'package:flutter_women_workout_ui/view/checkout/checkout_provider.dart';
import 'package:flutter_women_workout_ui/view/checkout/payment_option_list_item.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    final args = Get.arguments as Package;
    context.read<CheckoutProvider>().initPayment(args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Subscriptions",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<CheckoutProvider>(
        builder: (context, value, child) => value.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: value.paymentMethods.length,
                itemBuilder: (context, index) =>
                    value.paymentMethods[index].isDirectPayment! || checkApple(value.paymentMethods[index])
                        ? SizedBox()
                        : PaymentOptionListItem(
                            paymentMethod: value.paymentMethods[index]),
              ),
      ),
    );
  }
  bool checkApple(PaymentMethods paymentMethod){
    return paymentMethod.paymentMethodEn!.contains('pple') && !Platform.isIOS;
  }
}
