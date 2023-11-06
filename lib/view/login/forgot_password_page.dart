import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/models/model_forgot_password.dart';
import 'package:flutter_women_workout_ui/util/color_category.dart';
import 'package:flutter_women_workout_ui/util/constant_url.dart';
import 'package:flutter_women_workout_ui/util/constant_widget.dart';
import 'package:flutter_women_workout_ui/view/controller/controller.dart';
import 'package:flutter_women_workout_ui/view/login/otp_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPage createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  ForgotController controller = Get.put(ForgotController());
  final forgotForm = GlobalKey<FormState>();

  Future<bool> _requestPop() {
    Get.back();

    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: bgDarkWhite,
          body: SafeArea(
            child: Container(
              child: ConstantWidget.getPaddingWidget(
                EdgeInsets.symmetric(horizontal: 20.h),
                Form(
                  key: forgotForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstantWidget.getVerSpace(20.h),
                      InkWell(
                        onTap: () {
                          _requestPop();
                        },
                        child: getSvgImage("arrow_left.svg"),
                      ),
                      ConstantWidget.getVerSpace(20.h),
                      Expanded(
                        flex: 1,
                        child: ListView(
                          children: [
                            ConstantWidget.getTextWidget(
                                'Forgot Password'.tr,
                                textColor,
                                TextAlign.left,
                                FontWeight.w700,
                                28.sp),
                            SizedBox(
                              height: 10.h,
                            ),
                            ConstantWidget.getMultilineCustomFont(
                                "We need your registration email for reset password!",
                                15.sp,
                                descriptionColor,
                                fontWeight: FontWeight.w500,
                                txtHeight: 1.46.h),
                            SizedBox(
                              height: 40.h,
                            ),
                            ConstantWidget.getCountryTextFiled(
                              context,
                              "Phone Number".tr,
                              controller.emailController,
                              onCounteryCodeChange: (code) {
                                if (code.code != null) {
                                  controller.code.value = code.dialCode!;
                                }
                              },
                              isEnable: false,
                              height: 50.h,
                              withprefix: true,
                              validator: (phoneNumber) {
                                if (phoneNumber == null ||
                                    phoneNumber.isEmpty) {
                                  return 'Please enter phone number';
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            // ConstantWidget.getDefaultTextFiledWithLabel(context,
                            //     "Phone Number", controller.emailController,
                            //     isEnable: false,
                            //     height: 50.h,
                            //     withprefix: true,
                            //     image: "mail.svg",
                            //     keyboardType: TextInputType.number,
                            //     inputFormatters: [
                            //       FilteringTextInputFormatter.digitsOnly
                            //     ], validator: (phoneNumber) {
                            //   if (phoneNumber == null || phoneNumber.isEmpty) {
                            //     return 'Please enter phone number';
                            //   }
                            //   return null;
                            // }),
                            SizedBox(
                              height: 40.h,
                            ),
                            ConstantWidget.getButtonWidget(
                                context, 'Submit'.tr, blueButton, () {
                              if (forgotForm.currentState!.validate()) {
                                checkValidation();
                              }
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  void checkValidation() {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    // if (ConstantUrl.isNotEmpty(controller.emailController.text)) {
    checkNetwork();
    // } else {
    //   ConstantUrl.showToast(S.of(context).fillDetails, context);
    // }
  }

  checkNetwork() async {
    bool isNetwork = await ConstantUrl.getNetwork();
    if (isNetwork) {
      forgotPassword();
    } else {
      getNoInternet(context);
    }
  }

  Future<void> forgotPassword() async {
    Map data = {
      ConstantUrl.paramMobile:
          controller.code.value + controller.emailController.text,
    };

    final response =
        await http.post(Uri.parse(ConstantUrl.forgotPasswordUrl), body: data);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      ForgotPasswordModel user = ForgotPasswordModel.fromJson(map);

      if (user.data!.success == 1) {
        sendPage();
      }

      if (user.data!.forgotpassword != null) {
        ConstantUrl.showToast(user.data!.forgotpassword!.error!, context);
      }
      print("res--1" + user.toString());
    }
  }

  void sendPage() {
    Get.to(OTPPage(controller.code.value + controller.emailController.text));
  }
}
