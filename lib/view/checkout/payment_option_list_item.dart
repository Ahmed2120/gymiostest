import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/view/checkout/checkout_provider.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';

import '../../util/color_category.dart';

class PaymentOptionListItem extends StatelessWidget {
  const PaymentOptionListItem({super.key, required this.paymentMethod, this.session});
  final PaymentMethods paymentMethod;
  final String? session;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(paymentMethod.paymentMethodId.toString()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: ListTile(
          leading: Image.network(paymentMethod.imageUrl!),
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
                context.read<CheckoutProvider>().pay(context,
                    paymentMethod.paymentMethodId, paymentMethod.totalAmount, session);
              },
              child: Text("Pay")),
        ),
      ),
    );
  }
}
