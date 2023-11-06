// To parse this JSON data, do
//
//     final subscriptionInfo = subscriptionInfoFromJson(jsonString);

import 'dart:convert';

SubscriptionInfo subscriptionInfoFromJson(String str) =>
    SubscriptionInfo.fromJson(json.decode(str));

class SubscriptionInfo {
  SubscriptionInfo({
    required this.id,
    required this.invoiceId,
    required this.userId,
    required this.userName,
    required this.packageName,
    required this.packageDuration,
    required this.amount,
    required this.startSubscribe,
    required this.endSubscribe,
    required this.createdAt,
  });

  int id;
  int invoiceId;
  int userId;
  String userName;
  String packageName;
  String packageDuration;
  String amount;
  DateTime startSubscribe;
  DateTime endSubscribe;
  DateTime createdAt;

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) =>
      SubscriptionInfo(
        id: json["id"],
        invoiceId: json["invoice_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        packageName: json["package_name"],
        packageDuration: json["package_duration"],
        amount: json["amount"],
        startSubscribe: DateTime.parse(json["start_subscribe"]),
        endSubscribe: DateTime.parse(json["end_subscribe"]),
        createdAt: DateTime.parse(json["created_at"]),
      );
}
