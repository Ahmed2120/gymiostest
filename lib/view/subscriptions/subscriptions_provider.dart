import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_women_workout_ui/models/package.dart';
import 'package:flutter_women_workout_ui/models/subscription_info.dart';

import '../../models/userdetail_model.dart';
import '../../util/constant_url.dart';

class SubscriptionsProvider extends ChangeNotifier {
  var dio = Dio();
  bool _isLoading = true;
  List<Package> _packages = [];
  List<SubscriptionInfo> _subscriptions = [];
  SubscriptionInfo? _subscriptionInfo;

  void init() async {
    await readPackages();

    await checkSubscription();
  }

  Future<void> readPackages() async {
    try {
      Response<String> response = await dio.get(ConstantUrl.packagesUrl,
          options: Options(contentType: Headers.formUrlEncodedContentType));

      _packages = packageFromJson(response.data!);
    } catch (e) {
      log(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> checkSubscription() async {
    try {
      final isLogin = await ConstantUrl.isLogin();
      if (!isLogin) return;
      UserDetail userDetail = await ConstantUrl.getUserDetail();
      Response<String> subscribtionsResponse = await dio.post(
          ConstantUrl.userSubscription,
          data: {"user_id": userDetail.userId},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      final subscriptionsMap = json.decode(subscribtionsResponse.data!);

      for (final mp in subscriptionsMap["data"] as List<dynamic>) {
        _subscriptions.add(SubscriptionInfo.fromJson(mp));
      }
      log(_subscriptions.length.toString());
      Response<String> response = await dio.get(ConstantUrl.userSubscription,
          queryParameters: {"user_id": userDetail.userId},
          options: Options(contentType: Headers.formUrlEncodedContentType));

      final map = json.decode(response.data!);
      if (map["data"] == null) {
        return;
      }
      _subscriptionInfo = SubscriptionInfo.fromJson(map["data"]);
    } catch (e) {
      log(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isSubscribed => checkSubscribe();
  SubscriptionInfo? get subscriptionInfo => _subscriptionInfo;
  List<Package> get packages => _packages;
  List<SubscriptionInfo> get subscriptions => _subscriptions;

  checkSubscribe() {
    bool sub = false;
    sub = _subscriptionInfo != null;
    if (sub) {
      sub = _subscriptionInfo!.endSubscribe.isAfter(DateTime.now());
    }
    return sub;
  }
}
