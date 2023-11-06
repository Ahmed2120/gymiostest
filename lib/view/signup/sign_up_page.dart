import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/models/check_register_model.dart';
import 'package:flutter_women_workout_ui/models/register_model.dart';
import 'package:flutter_women_workout_ui/util/constants.dart';

import 'package:get/get.dart';

import '../../dialog/account_created_dialog.dart';
import '../../models/guide_intro_model.dart';
import '../../routes/app_routes.dart';
import '../../util/color_category.dart';
import '../../util/constant_url.dart';
import '../../util/constant_widget.dart';

import '../controller/controller.dart';

import 'verify_code_page.dart';

class SignUpPage extends StatefulWidget {
  final GuideIntroModel dataModel;

  SignUpPage(this.dataModel);

  @override
  _SignUpPage createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  SignUpController controller = Get.put(SignUpController());
  var dio = Dio();

  Future<bool> _requestPop() {
    Get.toNamed(Routes.signInRoute);
    return new Future.value(false);
  }

  RegExp emaailExpress = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final signUpForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgDarkWhite,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Form(
                key: signUpForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstantWidget.getVerSpace(20.h),
                    InkWell(
                        onTap: () {
                          _requestPop();
                        },
                        child: getSvgImage("arrow_left.svg",
                            width: 24.h, height: 24.h)),
                    ConstantWidget.getVerSpace(20.h),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          ConstantWidget.getTextWidget("Sign Up".tr, textColor,
                              TextAlign.left, FontWeight.w700, 28.sp),
                          ConstantWidget.getVerSpace(10.h),
                          ConstantWidget.getTextWidget(
                              "Create a account".tr,
                              descriptionColor,
                              TextAlign.left,
                              FontWeight.w500,
                              15.sp),
                          ConstantWidget.getVerSpace(40.h),
                          ConstantWidget.getDefaultTextFiledWithLabel(context,
                              "Full Name".tr, controller.fullNameController,
                              isEnable: false,
                              height: 50.h,
                              withprefix: true,
                              image: "profile.svg", validator: (fullName) {
                            if (fullName == null || fullName.isEmpty) {
                              return "Please enter full name.";
                            }
                            return null;
                          }),
                          ConstantWidget.getVerSpace(20.h),
                          ConstantWidget.getDefaultTextFiledWithLabel(
                              context, "Email".tr, controller.emailController,
                              isEnable: false,
                              height: 50.h,
                              withprefix: true,
                              image: "mail.svg", validator: (email) {
                            if (email == null || email.isEmpty) {
                              return "Please enter email";
                            }
                            if (!emaailExpress.hasMatch(email)) {
                              return "Please enter valid email.";
                            }
                            return null;
                          }),
                          ConstantWidget.getVerSpace(20.h),
                          ConstantWidget.getCountryTextFiled(
                              context,
                              onCounteryCodeChange: (code) {
                                if (code.code != null) {
                                  controller.code.value = code.dialCode!;
                                }
                              },
                              "Phone Number".tr,
                              controller.phoneNumberController,
                              isEnable: false,
                              height: 50.h,
                              withprefix: true,
                              validator: (number) {
                                if (number == null || number.isEmpty) {
                                  return "Please enter phone number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                          ConstantWidget.getVerSpace(20.h),
                          ConstantWidget.getDefaultTextFiledWithLabel(
                            context,
                            "Password".tr,
                            controller.textPasswordController,
                            isEnable: false,
                            height: 50.h,
                            withprefix: true,
                            image: "eye.svg",
                            isPass: true,
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return "Please enter password.";
                              }
                              return null;
                            },
                          ),
                          ConstantWidget.getVerSpace(20.h),
                          Row(
                            children: [
                              ConstantWidget.getHorSpace(10.h),
                              GetX<SignUpController>(
                                init: SignUpController(),
                                builder: (controller) => InkWell(
                                    onTap: () {
                                      controller.onCheck();
                                    },
                                    child: getSvgImage(
                                        controller.check.value == true
                                            ? "check.svg"
                                            : "uncheck.svg",
                                        height: 20.h,
                                        width: 20.h)),
                              ),
                              ConstantWidget.getHorSpace(12.h),
                              ConstantWidget.getTextWidget(
                                  "I agree with Terms & Privacy".tr,
                                  textColor,
                                  TextAlign.start,
                                  FontWeight.w300,
                                  15.sp)
                            ],
                          ),
                          ConstantWidget.getVerSpace(40.h),
                          GetBuilder<SignUpController>(
                            init: SignUpController(),
                            builder: (controller) =>
                                ConstantWidget.getButtonWidget(
                                    context, 'Sign Up'.tr, blueButton, () {
                              if (signUpForm.currentState!.validate()) {
                                if (controller.check.value == true) {
                                  checkValidation();
                                } else {
                                  Constants.showToast(
                                      "Please check term & Privacy.");
                                }
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.signInRoute);
                      },
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstantWidget.getRichText(
                            "Already have a account?".tr + " ",
                            descriptionColor,
                            FontWeight.w500,
                            17.sp,
                            "Login".tr,
                            textColor,
                            FontWeight.w700,
                            17.sp),
                      ),
                    ),
                    ConstantWidget.getVerSpace(40.h)
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  void checkValidation() {
    sendSignInPage();
  }

  String? pinCode;

  Future<void> checkRegister() async {
    final response = await dio.post(
      ConstantUrl.checkAlreadyRegisterUrl,
      data: {
        ConstantUrl.paramMobile:
            controller.code.value + controller.phoneNumberController.text,
        ConstantUrl.paramEmail: controller.fullNameController.text
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);

      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      print("response-12-----${response.data}");
      CheckRegisterModel user = CheckRegisterModel.fromJson(map);

      if (user.data!.success == 0) {
        print(controller.code.value + controller.phoneNumberController.text);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyCodePage(
                  controller.code.value + controller.phoneNumberController.text,
                  (value) {
                checkNetwork();
              }),
            ));
      } else {
        ConstantUrl.showToast(user.data!.login!.error!, context);
      }
    }
  }

  void sendSignInPage() async {
    bool isNetwork = await ConstantUrl.getNetwork();
    if (isNetwork) {
      checkRegister();
    } else {
      getNoInternet(context);
    }
  }

  checkNetwork() async {
    bool isNetwork = await ConstantUrl.getNetwork();
    if (isNetwork) {
      signUp();
    } else {
      getNoInternet(context);
    }
  }

  Future<void> signUp() async {
    String deviceId = await ConstantUrl.getDeviceId();

    final response = await dio.post(ConstantUrl.registerUrl,
        data: {
          ConstantUrl.paramFirstName: controller.fullNameController.text,
          ConstantUrl.paramLastName: "ghjg",
          ConstantUrl.paramUserName: controller.fullNameController.text,
          ConstantUrl.paramEmail: controller.emailController.text,
          ConstantUrl.paramPassword: controller.textPasswordController.text,
          ConstantUrl.paramMobile:
              controller.code.value + controller.phoneNumberController.text,
          ConstantUrl.paramAge: widget.dataModel.age,
          ConstantUrl.paramGender: widget.dataModel.gender,
          ConstantUrl.paramHeight: widget.dataModel.height,
          ConstantUrl.paramWeight: widget.dataModel.weight,
          ConstantUrl.paramAddress: "sdsd",
          ConstantUrl.paramCity: "sdsd",
          ConstantUrl.paramState: "sdsd",
          ConstantUrl.paramCountry: "sdsd",
          ConstantUrl.paramTimeInWeek: widget.dataModel.timeInWeek,
          ConstantUrl.paramIntensively: "sdsd",
          ConstantUrl.paramDeviceId: deviceId,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);

      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      RegisterModel user = RegisterModel.fromJson(map);

      ConstantUrl.showToast(user.dataModel.login!.error!, context);

      if (user.dataModel.success == 1) {
        showDialog(
            barrierDismissible: false,
            builder: (context) {
              return AccountCreateDialog();
            },
            context: context);
      }
      print("res--1" + user.toString());
    }
  }
}
