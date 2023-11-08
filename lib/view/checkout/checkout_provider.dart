import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_women_workout_ui/models/package.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/subscriptions_provider.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'package:provider/provider.dart';

import '../../models/userdetail_model.dart';
import '../../routes/app_routes.dart';
import '../../util/constant_url.dart';

class CheckoutProvider extends ChangeNotifier {
  var dio = Dio();
  bool _isLoading = true;
  bool _paymentInProgress = false;
  List<PaymentMethods> _paymentMethods = [];
  late Package _package;
  bool get isLoading => _isLoading;
  List<PaymentMethods> get paymentMethods => _paymentMethods;
  void init() async {
    MFSDK.init(
        "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
        MFCountry.EGYPT,
        MFEnvironment.TEST);
  }

  void initPayment(Package package) {
    _package = package;
    var request = new MFInitiatePaymentRequest(
        double.parse(package.price), MFCurrencyISO.Egyptian_Pound_EGP);

    MFSDK.initiatePayment(request, MFAPILanguage.EN, (result) {
      if (result.isSuccess()) {
        _paymentMethods = result.response!.paymentMethods!;
      } else {
        print(result.error?.message);
      }

      _isLoading = false;
      notifyListeners();
    });
  }

  void pay(BuildContext context, paymentId, price, String? session) async {
    final subProvider = context.read<SubscriptionsProvider>();
    if (_paymentInProgress)
      return;
    else
      _paymentInProgress = true;
    var request = new MFExecutePaymentRequest(paymentId, price);
    request.displayCurrencyIso = MFCurrencyISO.Egyptian_Pound_EGP;
    request.sessionId = session;

    MFSDK.callExecutePaymentForInAppApplePay(context, request, MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) async {
      if (result.isSuccess()) {
        await addSubscription(result.response!.invoiceId!.toString());
        subProvider.checkSubscription();
        Get.until(
          (route) => Get.currentRoute == Routes.subscriptionsRoute,
        );
      } else {
        Get.snackbar("Error", result.error!.toJson().toString());
      }
      _paymentInProgress = false;
      notifyListeners();
    });
  }

  Future<void> addSubscription(
    String invoiceId,
  ) async {
    try {
      UserDetail userDetail = await ConstantUrl.getUserDetail();

      final response = await dio.post(ConstantUrl.addSubscription,
          data: {
            "invoice_id": invoiceId,
            "user_id": userDetail.userId,
            "user_name": userDetail.firstName,
            "package_name": _package.name,
            "package_duration": _package.duration,
            "amount": _package.price
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));

      Get.snackbar("Sucess", "you have subscribed successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    notifyListeners();
  }
}
