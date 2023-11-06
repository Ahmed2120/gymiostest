import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/view/controller/controller.dart';
import '../routes/app_routes.dart';
import 'package:get/get.dart';

import 'util/color_category.dart';
import 'util/constant_widget.dart';
import 'util/pref_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    Get.put(SettingController());
    _getIsFirst();
  }

  _getIsFirst() async {
    isFirst = await PrefData().getIsFirstIntro();
    bool _isSignIn = await PrefData.getIsSignIn();
    // bool isIntro = await PrefData.getIsIntro();
    // if (isIntro) {
    //   Timer(Duration(seconds: 3), () {
    //     Get.toNamed(Routes.guideIntroRoute);
    //   });
    // } else
      if (!_isSignIn) {
      Timer(Duration(seconds: 3), () {
        Get.toNamed(Routes.signInRoute);
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Get.toNamed(Routes.homeScreenRoute, arguments: 0);
      });
    }
  }

  ThemeData themeData = new ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor));

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      appBar: getColorStatusBar(bgDarkWhite),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: bgDarkWhite,
          child: Center(
            child: Image.asset("assets/images/logo.png",
                height: 250.h, width: 250.h),

            // ConstantWidget.getTextWidget("Fitness", Colors.black,
            //     TextAlign.center, FontWeight.w500, 36)
          ),
        ),
      ),
    );
  }
}
