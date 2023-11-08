import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/view/checkout/checkout_provider.dart';
import 'package:myfatoorah_flutter/embeddedapplepay/MFApplePayButton.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';

import '../../util/color_category.dart';

class PaymentOptionListItem extends StatelessWidget {
  PaymentOptionListItem({super.key, required this.paymentMethod, this.session});
  final PaymentMethods paymentMethod;
  final MFInitiateSessionResponse? session;

  MFApplePayButton mfApplePayButton = MFApplePayButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(paymentMethod.paymentMethodId.toString()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: ListTile(
          leading: SizedBox(
            height: 12,
              width: 12,
              child: mfApplePayButton),
          title: Text(
            paymentMethod.paymentMethodEn!,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${paymentMethod.totalAmount}${paymentMethod.currencyIso}",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: accentColor),
          ),
          trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: accentColor),
              onPressed: () {
                // context.read<CheckoutProvider>().pay(context,
                //     paymentMethod.paymentMethodId, paymentMethod.totalAmount, session);
                var request = MFExecutePaymentRequest.constructorForApplyPay(
                    0.100, MFCurrencyISO.Egyptian_Pound_EGP);
                mfApplePayButton.load(session!, request, MFAPILanguage.EN, (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
                  if (result.isSuccess())
                    {
                      print('sucues: 1111111111111111111111111111111111'),

                    }
                  else
                    {

                    }
                });
              },
              child: Text("Pay")),
        ),
      ),
    );
  }

  void loadApplePay(MFInitiateSessionResponse mfInitiateSessionResponse) {
    var request = MFExecutePaymentRequest.constructorForApplyPay(
        0.100, MFCurrencyISO.Egyptian_Pound_EGP);
    mfApplePayButton.loadWithStartLoading(
        mfInitiateSessionResponse,
        request,
        MFAPILanguage.EN,
            () {
          // setState(() {
          //   // _response = "Loading...";
          // });
        },
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              print('sucues: 1111111111111111111111111111111111'),
              // setState(() {
              //   print("invoiceId: " + invoiceId);
              //   print("Response: " + result.response!.toJson().toString());
              //   // _response = result.response!.toJson().toString();
              // })
            }
          else
            {
              // setState(() {
              //   print("invoiceId: " + invoiceId);
              //   print("Error: " + result.error!.toJson().toString());
              //   // _response = result.error!.message!;
              // })
            }
        });
  }
}
