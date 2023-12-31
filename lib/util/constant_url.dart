import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_women_workout_ui/util/service_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';

import '../data/dummy_data.dart';
import '../models/intensively_model.dart';
import '../models/model_delete_custom_plan_exercise.dart';
import '../models/userdetail_model.dart';
import '../view/login/sign_in_page.dart';
import 'pref_data.dart';

class ConstantUrl {
  static String mainUrl =
      'https://cofoclub.com/club/'; //'https://workout.dev.tqnia.me/';
  static String baseUrl = mainUrl + 'api/';
  static String uploadUrl = mainUrl + 'uploads/';
  static String registerUrl = baseUrl + "register.php";
  static String deleteAccountUrl = baseUrl + "deleteaccount.php";
  static String packagesUrl = baseUrl + "package.php";

  static String addSubscription = baseUrl + "addSubscription.php";
  static String userSubscription = baseUrl + "subscriptionUser.php";
  static String urlUpdatePassword = baseUrl + "updatepassword.php";
  static String urlResetPassword = baseUrl + "changepassword.php";
  static String forgotPasswordUrl = baseUrl + "forgotpassword.php";
  static String checkAlreadyRegisterUrl = baseUrl + "checkalreadyregister.php";
  static String loginUrl = baseUrl + "login.php";
  static String urlGetAllChallenge = baseUrl + "challenges.php";
  static String urlGetAllWorkout = baseUrl + "category.php";
  static String urlGetSubWorkout = baseUrl + "subcategory.php";
  static String urlGetChallengeWeek = baseUrl + "getweek.php";
  static String urlGetChallengeDays = baseUrl + "getdays.php";
  static String urlGetChallengeExercise = baseUrl + "challengesexercise.php";
  static String urlAddCompleteWeek = baseUrl + "weekcompleted.php";
  static String urlAddCompleteDay = baseUrl + "daycompleted.php";
  static String urlAddHistory = baseUrl + "workoutscompleted.php";
  static String urlGetHomeWorkout = baseUrl + "gethomeworkout.php";
  static String urlAddHomeWorkout = baseUrl + "homeworkout.php";
  static String urlGetWorkoutExercise = baseUrl + "categoryexercise.php";
  static String urlGetAllDiscover = baseUrl + "discover.php";
  static String urlGetAllQuickWorkout = baseUrl + "quickworkout.php";
  static String urlGetAllStretches = baseUrl + "stretches.php";
  static String urlGetDiscoverExercise = baseUrl + "discoverexercise.php";
  static String urlGetQuickWorkoutExercise =
      baseUrl + "quickworkoutexercise.php";
  static String urlGetStretchesExercise = baseUrl + "stretchesexercise.php";
  static String urlGetWorkoutCompleted = baseUrl + "getworkoutcompleted.php";
  static String urlEditProfile = baseUrl + "editprofile.php";
  static String logOutUrl = baseUrl + "logout.php";
  static String urlAddCustomPlan = baseUrl + "customplan.php";
  static String urlGetCustomPlan = baseUrl + "getcustomplan.php";
  static String urlAddCustomPlanExercise = baseUrl + "customplanexercise.php";
  static String urlEditCustomPlanExercise =
      baseUrl + "editcustomplanexercise.php";
  static String urlGetCustomPlanExercise =
      baseUrl + "getcustomplanexercise.php";
  static String urlDeleteCustomPlanExercise =
      baseUrl + 'deletecustomplanexercise.php';
  static String urlDeleteCustomPlan = baseUrl + "deletecustomplan.php";
  static String urlEditCustomPlan = baseUrl + "editcustomplan.php";
  static String urlSetting = baseUrl + "setting.php";

  static String paramUserName = "username";
  static String paramMobile = "mobile";
  static String paramEmail = "email";
  static String paramOldPassword = "oldpassword";
  static String paramNewPassword = "newpassword";
  static String paramPassword = "password";
  static String paramDeviceId = "device_id";
  static String paramFirstName = "first_name";
  static String paramLastName = "last_name";
  static String paramAge = "age";
  static String paramGender = "gender";
  static String paramHeight = "height";
  static String paramWeight = "weight";
  static String paramTimeInWeek = "timeinweek";
  static String paramIntensively = "intensively";
  static String paramCity = "city";
  static String paramState = "state";
  static String paramAddress = "address";
  static String paramCountry = "country";
  static String paramUserId = "user_id";
  static String paramChallengeId = "challenges_id";
  static String paramSession = "session";
  static String paramChallengeWeekId = "week_id";
  static String paramDaysId = "days_id";
  static String varDaysId = "days_id";
  static String varWeekId = "week_id";
  static String paramKcal = "kcal";
  static String paramCompleteDuration = "completed_duration";
  static String paramCompleteDate = "completed_date";
  static String paramWorkoutType = "workout_type";
  static String paramWorkoutId = "workout_id";
  static String paramWorkout = "workouts";
  static String paramDuration = "duration";
  static String varCatId = "category_id";
  static String varDiscoverId = "discover_id";
  static String varQuickWorkoutId = "quickworkout_id";
  static String varStretchesId = "stretches_id";
  static String paramImage = "image";
  static String paramName = 'name';
  static String paramDescription = "description";
  static String paramCustomPlanId = "custom_plan_id";
  static String paramExerciseId = "exercise_id";
  static String paramExerciseTime = "exercise_time";
  static String paramCustomPlanExerciseId = "custom_plan_exercise_id";

  static Future<String> getDeviceId() async {
    String? deviceId = "";

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    return deviceId!;
  }

  static Future<bool> isLogin() async {
    return await PrefData.getIsSignIn();
  }

  static bool isNotEmpty(String s) {
    return (s.isNotEmpty);
  }

  static Future<bool> getNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Map> getCommonParams() async {
    bool _isSignIn = await PrefData.getIsSignIn();
    String s = await PrefData.getUserDetail();
    String deviceId = await ConstantUrl.getDeviceId();
    String session = await PrefData.getSession();

    print("service---1" + s);
    if (_isSignIn && s.isNotEmpty) {
      Map<String, dynamic> userMap;
      userMap = jsonDecode(s) as Map<String, dynamic>;

      final UserDetail user = UserDetail.fromJson(userMap);
      print(user);

      print("addWholeHistory-----${user.userId}---$session---$deviceId");
      return {
        ConstantUrl.paramUserId: user.userId,
        ConstantUrl.paramSession: session,
        ConstantUrl.paramDeviceId: deviceId,
      };
    } else {
      return {
        ConstantUrl.paramUserId: '',
        ConstantUrl.paramSession: 'session',
        ConstantUrl.paramDeviceId: '',
      };
    }
  }

  static Future<UserDetail> getUserDetail() async {
    String s = await PrefData.getUserDetail();
    print("service---1" + s);
    if (s.isNotEmpty) {
      Map<String, dynamic> userMap;
      userMap = jsonDecode(s) as Map<String, dynamic>;

      final UserDetail user = UserDetail.fromJson(userMap);
      print(user);
      print("service---" + user.toString());

      return user;
    } else {
      return new UserDetail();
    }
  }

  static void sendLoginPage(BuildContext context, {Function? function}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        )).then((value) {
      if (function != null) {
        function();
      }
    });
  }

  static showToast(String s, BuildContext context) {
    if (s.isNotEmpty) {
      Fluttertoast.showToast(
          msg: s,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12);

      // Toast.show(s, context,
      //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  static List<IntensivelyModel> getIntensivelyModel() {
    List<IntensivelyModel> list = [];

    IntensivelyModel model = new IntensivelyModel();
    model.title = "Low";
    model.desc =
        "Low impact strength training refers to exercise that is easy and gentle on your joints and tendons.";
    list.add(model);

    model = new IntensivelyModel();
    model.title = "Moderate";
    model.desc =
        "Many physical activity recommendations report that moderate exercise is important for health and well-being.";
    list.add(model);

    model = new IntensivelyModel();
    model.title = "High";
    model.desc =
        "While it's often referred to as \"runner's high,\"these feelings can also occur with other forms of aerobic.";
    list.add(model);

    return list;
  }

  static List<IntensivelyModel> getTimeInWeekModel() {
    List<IntensivelyModel> list = [];

    IntensivelyModel model = new IntensivelyModel();
    model.title = "2-3 Times in week";
    model.desc =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.";
    list.add(model);

    model = new IntensivelyModel();
    model.title = "5 Days in week";
    model.desc =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.";
    list.add(model);

    model = new IntensivelyModel();
    model.title = "7 Days in week";
    model.desc =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.";
    list.add(model);

    return list;
  }

  static deleteExercise(BuildContext context, Function function,
      String customPlanExerciseId, String id) async {
    Map data = await ConstantUrl.getCommonParams();
    data[ConstantUrl.paramCustomPlanExerciseId] = customPlanExerciseId;

    final response = await http
        .post(Uri.parse(ConstantUrl.urlDeleteCustomPlanExercise), body: data);

    DummyData.removeExercise(id);
    var value =
        ModelDeleteCustomPlanExercise.fromJson(jsonDecode(response.body));

    ConstantUrl.showToast(value.data.error, context);
    checkLoginError(context, value.data.error);
    if (value.data.success == 1) {
      function();
    }
  }
}
