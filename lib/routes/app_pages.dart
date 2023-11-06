import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/view/language/language_screen.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/subscriptions_history_screen.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/subscriptions_screen.dart';
import '../view/checkout/checkout_screen.dart';
import '../view/home/home_widget.dart';
import '../view/setting/widget_health_info.dart';
import '../view/activity/activity_list.dart';

import '../view/intro/guide_intro_page.dart';
import '../intro_page.dart';
import '../view/login/forgot_password_page.dart';
import '../view/login/sign_in_page.dart';
import '../splash_screen.dart';
import '../routes/app_routes.dart';
import '../view/setting/edit_profile.dart';
import '../view/signup/select_country.dart';
import '../view/workout_category/workout_category_list.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => SplashScreen(),
    Routes.guideIntroRoute: (context) => GuideIntroPage(),
    Routes.signInRoute: (context) => SignInPage(),
    Routes.forgotPasswordRoute: (context) => ForgotPasswordPage(),
    Routes.introRoute: (context) => IntroPage(),
    // Routes.signUpRoute: (context) => SignUpPage(),
    Routes.selectCountryRoute: (context) => SelectCountry(),
    Routes.workoutCategoryListRoute: (context) => WorkoutCategoryList(),
    // Routes.selectworkoutRoute: (context) => SelectWorkout(),
    // Routes.selectedListRoute: (context) => SelectedList(),
    Routes.activityListRoute: (context) => ActivityList(),
    Routes.editProfileRoute: (context) => EditProfile(),
    Routes.healthInfoRoute: (context) => HealthInfo(),
    Routes.homeScreenRoute: (context) => HomeWidget(),
    Routes.subscriptionsRoute: (context) => SubscriptionsScreen(),
    Routes.checkoutRoute: (context) => CheckoutScreen(),
    Routes.subscriptionHistoryRoute: (context) => SubscriptionsHistoryScreen(),
    Routes.languageRoute: (context) => LanguageScreen()
  };
}
