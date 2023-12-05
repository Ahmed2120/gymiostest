import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfatoorah_flutter/embeddedapplepay/MFApplePayButton.dart';
import 'package:myfatoorah_flutter/embeddedpayment/MFPaymentCardView.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/package.dart';
import '../../util/color_category.dart';
import '../../util/constant_widget.dart';
import 'checkout_provider.dart';

class ApplePayScreen extends StatefulWidget {
  ApplePayScreen({super.key});

  @override
  State<ApplePayScreen> createState() => _ApplePayScreenState();
}

class _ApplePayScreenState extends State<ApplePayScreen> {
  MFApplePayButton? mfApplePayButton;

  Package? args;

  @override
  void initState() {
    super.initState();
    args = Get.arguments as Package;
    initiateSession();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Expanded(child: createApplePayButton(),),
            // ElevatedButton(onPressed: ()async{
            //
            //
            // }, child: Text('pay'))
            // getButton(context, accentColor, "Pay".tr, Colors.white,
            //         () {
            //       context.read<CheckoutProvider>().cardPay(
            //           context, mfPaymentCardView, double.parse(args!.price));
            //     }, 20.sp,
            //     weight: FontWeight.w700,
            //     buttonHeight: 60.h,
            //     borderRadius: BorderRadius.circular(22.h)),
          ],
        ),
      ),
    );
  }


  void initiateSession() {
    MFSDK.initiateSession(null, (MFResult<MFInitiateSessionResponse> result) =>
    {
      if(result.isSuccess())
        // loadApplePay(result.response!)
    context.read<CheckoutProvider>().loadApplePay(context, result.response!, mfApplePayButton!, double.parse(args!.price))
        else
        print(result.error?.toJson().toString())
    });
  }



  createApplePayButton() {
    mfApplePayButton = MFApplePayButton();
    return mfApplePayButton;
  }
}
