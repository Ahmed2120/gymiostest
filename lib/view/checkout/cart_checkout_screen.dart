import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfatoorah_flutter/embeddedpayment/MFPaymentCardView.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/package.dart';
import '../../util/color_category.dart';
import '../../util/constant_widget.dart';
import 'checkout_provider.dart';

class CartCheckoutScreen extends StatefulWidget {
  CartCheckoutScreen({super.key});

  @override
  State<CartCheckoutScreen> createState() => _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  MFPaymentCardView? mfPaymentCardView;

  Package? args;

  @override
  void initState() {
    super.initState();
    args = Get.arguments as Package;
    initiateSession();
  }

  void initiateSession() async{
    print(';;;;;;;;;;;;');
    /**
     * If you want to use saved card option with embedded payment, send the parameter
     * "customerIdentifier" with a unique value for each customer. This value cannot be used
     * for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");

    /**
     * If not, then send null like this.
     */
    MFSDK.initiateSession(null, (MFResult<MFInitiateSessionResponse> result) => {
    if(result.isSuccess())
    mfPaymentCardView?.load(result.response!,
    onCardBinChanged: (String bin) => {print("Bin: " + bin)})
    else
    print("Response: " + "${result.error!.toJson()}")
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Expanded( child: createPaymentCardView(),),
            // ElevatedButton(onPressed: ()async{
            //
            //
            // }, child: Text('pay'))
            getButton(context, accentColor, "Pay".tr, Colors.white,
                    () {
                      context.read<CheckoutProvider>().cardPay(context, mfPaymentCardView, double.parse(args!.price));
                }, 20.sp,
                weight: FontWeight.w700,
                buttonHeight: 60.h,
                borderRadius: BorderRadius.circular(22.h)),
          ],
        ),
      ),
    );

  }

  createPaymentCardView() {
    if(mfPaymentCardView == null)
      mfPaymentCardView = MFPaymentCardView(
        inputColor: Colors.black,
        labelColor: Colors.grey,
        errorColor: Colors.red,
        borderColor: Colors.green,
        fontSize: 20,
        borderWidth: 1,
        borderRadius: 10,
        cardHeight: 350,
        cardHolderNameHint: "card holder name hint",
        cardNumberHint: "card number hint",
        expiryDateHint: "expiry date hint",
        cvvHint: "cvv hint",
        showLabels: true,
        cardHolderNameLabel: "card holder name label",
        cardNumberLabel: "card number label",
        expiryDateLabel: "expiry date label",
        cvvLabel: "securtity code label",
      );
    return mfPaymentCardView;
  }
}
