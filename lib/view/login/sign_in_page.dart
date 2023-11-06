import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/models/login_model.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/subscriptions_provider.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../util/color_category.dart';
import '../../util/constant_url.dart';
import '../../util/constant_widget.dart';
import '../../util/constants.dart';

import 'package:get/get.dart';

import '../../util/pref_data.dart';
import '../controller/controller.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() {
    return _SignInPage();
  }
}

class _SignInPage extends State<SignInPage> {
  LoginController controller = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());
  final loginForm = GlobalKey<FormState>();

  Future<bool> _requestPop() {
    exitApp();
    return new Future.value(false);
  }

  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(bgDarkWhite);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgDarkWhite,
          appBar: getNoneAppBar(context),
          body: Container(
            child: Form(
              key: loginForm,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      children: [
                        SizedBox(
                          height: 80.h,
                        ),
                        ConstantWidget.getTextWidget("Login".tr, textColor,
                            TextAlign.left, FontWeight.w700, 28.sp),
                        SizedBox(
                          height: 10.h,
                        ),
                        ConstantWidget.getTextWidget(
                            "Welcome back to our account".tr,
                            descriptionColor,
                            TextAlign.left,
                            FontWeight.w500,
                            15.sp),
                        SizedBox(
                          height: 40.h,
                        ),
                        ConstantWidget.getDefaultTextFiledWithLabel(
                            context, "Username".tr, controller.emailController,
                            isEnable: false,
                            height: 50.h,
                            withprefix: true,
                            image: "mail.svg", validator: (username) {
                          if (username == null || username.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        }),
                        SizedBox(
                          height: 20.h,
                        ),
                        ConstantWidget.getDefaultTextFiledWithLabel(context,
                            "Password".tr, controller.passwordController,
                            isEnable: false,
                            height: 50.h,
                            withprefix: true,
                            image: "eye.svg",
                            isPass: true, validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Please enter password';
                          }
                          if (password.length < 6) {
                            return "Please atleast 6 digit password enter.";
                          }
                          return null;
                        }),
                        ConstantWidget.getVerSpace(20.h),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: ConstantWidget.getTextWidget(
                                    'Forgot Password?'.tr,
                                    textColor,
                                    TextAlign.end,
                                    FontWeight.w500,
                                    17.sp),
                                onTap: () {
                                  Get.toNamed(Routes.forgotPasswordRoute);
                                },
                              ),
                            ),
                          ],
                        ),
                        ConstantWidget.getVerSpace(40.h),
                        ConstantWidget.getButtonWidget(
                            context, 'Login'.tr, blueButton, () {
                          if (loginForm.currentState!.validate()) {
                            checkValidation();
                          }
                        }),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Get.toNamed(Routes.introRoute);
                    },
                    child: ConstantWidget.getRichText(
                        "Don't have an account?".tr + " ",
                        descriptionColor,
                        FontWeight.w500,
                        17.sp,
                        "Sign Up".tr,
                        textColor,
                        FontWeight.w700,
                        17.sp),
                  ),
                  ConstantWidget.getVerSpace(36.h)
                ],
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
    //
    // if (ConstantUrl.isNotEmpty(controller.emailController.text) &&
    //     ConstantUrl.isNotEmpty(controller.passwordController.text)) {
    checkNetwork();
    // } else {
    //   ConstantUrl.showToast(S.of(context).fillDetails, context);
    // }
  }

  checkNetwork() async {
    bool isNetwork = await ConstantUrl.getNetwork();
    if (isNetwork) {
      signIn();
    } else {
      getNoInternet(context);
    }
  }

  Future<void> signIn() async {
    String deviceId = await ConstantUrl.getDeviceId();

    var data = {
      ConstantUrl.paramUserName: controller.emailController.text,
      ConstantUrl.paramPassword: controller.passwordController.text,
      ConstantUrl.paramDeviceId: deviceId,
    };

    final response = await dio.post(
      ConstantUrl.loginUrl,
      data: data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);

      ModelLogin user = ModelLogin.fromJson(map);
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      ConstantUrl.showToast(user.data.login.error!, context);

      if (user.data.success == 1) {
        context.read<SubscriptionsProvider>().checkSubscription();
        PrefData.setUserDetail(json.encode(user.data.login.userdetail));
        PrefData.setSession(user.data.login.session!);
        PrefData.setIsSignIn(true);
        controller.emailController.text = "";
        controller.passwordController.text = "";
        homeController.onChange(0.obs);
        Get.toNamed(Routes.homeScreenRoute, arguments: 0);
      }
    }
  }
}
