import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/models/package.dart';
import 'package:flutter_women_workout_ui/view/checkout/checkout_provider.dart';
import 'package:flutter_women_workout_ui/view/checkout/payment_option_list_item.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/embeddedapplepay/MFApplePayButton.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late MFApplePayButton mfApplePayButton;
  String? session;

  @override
  void initState() {
    final args = Get.arguments as Package;
    context.read<CheckoutProvider>().initPayment(args);
    initiateSession();
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
                    value.paymentMethods[index].isDirectPayment!
                        ? SizedBox()
                        :  PaymentOptionListItem(
                            paymentMethod: value.paymentMethods[index], session: session,),
              ),
      ),
    );
  }

  createApplePayButton() {
    mfApplePayButton = MFApplePayButton();
    return mfApplePayButton;
  }

  void initiateSession() {
    MFSDK.initiateSession(null, (MFResult<MFInitiateSessionResponse> result) => {
      print('...................................................'),
      print('...................................................'),
      if(result.isSuccess())
        {
                  print('...................................................'),
                  // loadApplePay(result.response!)
          session = result.response?.sessionId
                }
              else
        print(result.error?.toJson().toString())
    });
  }

  void loadApplePay(MFInitiateSessionResponse mfInitiateSessionResponse) {
    var request = MFExecutePaymentRequest.constructorForApplyPay(
        0.100, MFCurrencyISO.Egyptian_Pound_EGP);
    mfApplePayButton.loadWithStartLoading(
        mfInitiateSessionResponse,
        request,
        MFAPILanguage.EN,
            () {
          setState(() {
            // _response = "Loading...";
          });
        },
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              print('sucues: 1111111111111111111111111111111111'),
              setState(() {
                print("invoiceId: " + invoiceId);
                print("Response: " + result.response!.toJson().toString());
                // _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print("invoiceId: " + invoiceId);
                print("Error: " + result.error!.toJson().toString());
                // _response = result.error!.message!;
              })
            }
        });
  }
}
