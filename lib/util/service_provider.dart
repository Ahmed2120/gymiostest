import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/models/model_exercise_week.dart';
import 'package:flutter_women_workout_ui/models/model_exrecise_days.dart';
import 'package:flutter_women_workout_ui/models/model_get_custom_plan.dart';
import 'package:flutter_women_workout_ui/models/model_get_custom_plan_exercise.dart';
import 'package:flutter_women_workout_ui/util/pref_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/home_workout.dart';
import '../models/model_add_day_complete.dart';
import '../models/model_add_week.dart';
import '../models/model_all_challenges.dart';
import '../models/model_all_workout_category.dart';
import '../models/model_detail_exercise_list.dart';
import '../models/model_discover.dart';
import '../models/model_dummy_send.dart';
import '../models/model_home_success.dart';
import '../models/model_quick_workout.dart';
import '../models/model_stretches.dart';
import '../models/model_workout_history.dart';
import '../models/setting_model.dart';
import '../models/userdetail_model.dart';
import '../routes/app_routes.dart';
import 'constant_url.dart';

var dio = Dio();

final PrettyDioLogger _logger = PrettyDioLogger(
  requestBody: true,
  responseBody: true,
  requestHeader: true,
  error: true,
);

Future<ModelAllChallenge> getAllChallenge(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();
  dio.interceptors.add(_logger);
  final response = await dio.post(ConstantUrl.urlGetAllChallenge,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType));

  print('jsonDecode(response.data) ${jsonDecode(response.data)}');
  var value = ModelAllChallenge.fromJson(jsonDecode(response.data));
  print('jsonDecode(momo) ${value.data.challenges.first.toJson()}');
  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelGetCustomPlan?> getCustomPlan(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();

  final response =
      await http.post(Uri.parse(ConstantUrl.urlGetCustomPlan), body: data);

  print("checkResponseCustom==${response.body}");
  var value = ModelGetCustomPlan.fromJson(jsonDecode(response.body));

  print("checkResponseCustom==${value}");

  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelGetCustomPlanExercise?> getCustomPlanExercise(
  BuildContext context,
) async {
  String customPlanId = await PrefData.getCustomPlanId();

  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.paramCustomPlanId] = customPlanId;

  final response = await http
      .post(Uri.parse(ConstantUrl.urlGetCustomPlanExercise), body: data);

  print("checkResponse==${response.body}");
  var value = ModelGetCustomPlanExercise.fromJson(jsonDecode(response.body));

  print("checkResponsevalue==${value.data.customplanexercise.length}");

  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelSetting> getSetting(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();
  final response =
      await http.post(Uri.parse(ConstantUrl.urlSetting), body: data);
  var value = ModelSetting.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data.error);
  return value;
}

Future<ModelAllWorkout?> getYogaWorkout(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();
  dio.interceptors.add(_logger);
  final response = await dio.post(ConstantUrl.urlGetAllWorkout,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType));
  print('hereeeeeeeeee');
  print("rescode===${response.statusCode}--${response.data}");

  var value = ModelAllWorkout.fromJson(jsonDecode(response.data));

  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelAllWorkout?> getSubYogaWorkout(
    BuildContext context, String catId) async {
  // Map data = await ConstantUrl.getCommonParams();
  dio.interceptors.add(_logger);
  final response = await dio.get(ConstantUrl.urlGetSubWorkout,
      queryParameters: {
        'parent_id': catId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType));
  print('subbbbbbbbbbb');
  print("rescode===${response.statusCode}--${response.data}");

  var value = ModelAllWorkout.fromJson(jsonDecode(response.data));

  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelExerciseWeek?> getChallengeWeek(
    BuildContext context, String challengeId) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.paramChallengeId] = challengeId;
  dio.interceptors.add(_logger);
  final response = await dio.post(ConstantUrl.urlGetChallengeWeek,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType));
  print('trtrytrytr ${response.data}');
  var value = ModelExerciseWeek.fromJson(jsonDecode(response.data));
  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelExerciseDays?> getChallengeDay(
    BuildContext context, String weekId) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.paramChallengeWeekId] = weekId;
  dio.interceptors.add(_logger);
  final response = await dio.post(ConstantUrl.urlGetChallengeDays,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType));
  print('aslkdj ${response.data}');
  var value = ModelExerciseDays.fromJson(jsonDecode(response.data));
  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelDetailExerciseList?> getChallengeDetailExerciseList(
    BuildContext context, String daysIdGet) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.paramDaysId] = daysIdGet;

  final response = await http
      .post(Uri.parse(ConstantUrl.urlGetChallengeExercise), body: data);
  print(
      "rescode==list=${ConstantUrl.urlGetChallengeExercise}==$daysIdGet--${response.body}");

  var value = ModelDetailExerciseList.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data.error);

  return value;
}

Future<AddWeekModel?> addComplete(BuildContext context, String weekId) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.paramChallengeWeekId] = weekId;

  final response =
      await http.post(Uri.parse(ConstantUrl.urlAddCompleteWeek), body: data);

  var value = AddWeekModel.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data!.error!);

  return value;
}

Future<AddDayComplete?> addDayComplete(
    BuildContext context, String dayId, String weekID) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.varDaysId] = dayId;
  data[ConstantUrl.varWeekId] = weekID;

  final response =
      await http.post(Uri.parse(ConstantUrl.urlAddCompleteDay), body: data);

  var value = AddDayComplete.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data!.error!);
  return value;
}

DateFormat addDateFormat = DateFormat("yyyy-MM-dd", "en-US");

Future<bool?> addWholeHistory(BuildContext context, double cal, int second,
    String workoutType, String id) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.paramKcal] = cal.toString();
  data[ConstantUrl.paramCompleteDuration] = second.toString();
  data[ConstantUrl.paramCompleteDate] = addDateFormat.format(DateTime.now());
  data[ConstantUrl.paramWorkoutType] = workoutType;
  data[ConstantUrl.paramWorkoutId] = id;

  print("addWholeHistory---id--$id");

  final response =
      await http.post(Uri.parse(ConstantUrl.urlAddHistory), body: data);

  print(
      "addWholeHistory---12--${response.body}===${response.statusCode}----${addDateFormat.format(DateTime.now())}");

  return true;
}

Future<HomeWorkout?> getHomeWorkoutData(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();

  final response =
      await http.post(Uri.parse(ConstantUrl.urlGetHomeWorkout), body: data);

  print("dataResponse-----${response.body}");
  var value = HomeSuccess.fromJson(jsonDecode(response.body));

  if (value.data!.success! == 1) {
    return HomeWorkout.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

addHistoryData(BuildContext context, String title, String startTime,
    int totalDuration, double cal, String id, String date) async {
  getHomeWorkoutData(context).then((value) {
    int second = 0;
    double kcal = 0;
    int workout = 0;
    if (value != null && value.data!.success == 1) {
      Homeworkout homeWorkout = value.data!.homeworkout!;
      second = int.parse(homeWorkout.duration!);
      kcal = double.parse(homeWorkout.kcal!);
      workout = int.parse(homeWorkout.workouts!);
    }

    second = second + totalDuration;
    kcal = kcal + cal;
    workout = workout + 1;

    addHomeWorkoutData(context, workout, kcal, second);
  });
}

Future<HomeWorkout?> addHomeWorkoutData(
    BuildContext context, int workout, double cal, int second) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.paramWorkout] = workout.toString();
  data[ConstantUrl.paramKcal] = cal.toString();
  data[ConstantUrl.paramDuration] = second.toString();

  final response =
      await http.post(Uri.parse(ConstantUrl.urlAddHomeWorkout), body: data);

  print("addResponse-----${response.body}");

  var value = HomeWorkout.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data!.error!);

  return value;
}

Future<ModelDetailExerciseList> getDetailExerciseList(
    BuildContext context, ModelDummySend dummySend) async {
  Map data = await ConstantUrl.getCommonParams();
  data[dummySend.sendParam] = dummySend.id;

  final response =
      await http.post(Uri.parse(dummySend.serviceName), body: data);
  print('helloooooooooooooo ${dummySend.serviceName}');
  print("rescode===${response.statusCode}--${response.body}");

  var value = ModelDetailExerciseList.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelDetailExerciseList?> getExerciseList(
    BuildContext context, String categoryId) async {
  Map data = await ConstantUrl.getCommonParams();
  data[ConstantUrl.varCatId] = categoryId;

  final response =
      await http.post(Uri.parse(ConstantUrl.urlGetWorkoutExercise), body: data);
  print("rescode===${response.statusCode}--${response.body}");

  var value = ModelDetailExerciseList.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelDiscover?> getAllDiscover(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();

  final response =
      await http.post(Uri.parse(ConstantUrl.urlGetAllDiscover), body: data);

  var value = ModelDiscover.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data.error);

  return value;
}

Future<ModelQuickWorkout?> getAllYogaStyleWorkout(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();

  final response =
      await http.post(Uri.parse(ConstantUrl.urlGetAllQuickWorkout), body: data);

  var value = ModelQuickWorkout.fromJson(jsonDecode(response.body));
  checkLoginError(context, value.data!.error!);

  print("ModelQuickWorkout====${response.body}");

  return value;
}

Future<ModelStretches?> getAllStretch(BuildContext context) async {
  Map data = await ConstantUrl.getCommonParams();

  final response =
      await http.post(Uri.parse(ConstantUrl.urlGetAllStretches), body: data);

  var value = ModelStretches.fromJson(jsonDecode(response.body));

  print("responseBody---${response.body}");
  checkLoginError(context, value.data!.error!);

  return value;
}

Future<WorkoutHistoryModel?> getAllWorkoutHistory(
    BuildContext context, String date) async {
  String deviceId = await ConstantUrl.getDeviceId();
  String s = await PrefData.getUserDetail();

  if (s.isNotEmpty) {
    UserDetail userDetail = await ConstantUrl.getUserDetail();
    String session = await PrefData.getSession();

    Map data = {
      ConstantUrl.paramSession: session,
      ConstantUrl.paramUserId: userDetail.userId,
      ConstantUrl.paramDeviceId: deviceId,
      ConstantUrl.paramCompleteDate: date,
    };

    final response = await http
        .post(Uri.parse(ConstantUrl.urlGetWorkoutCompleted), body: data);

    if (response.body.isEmpty) {
      return null;
    }
    print("urlGetAllCustomDietPlan=1212==-${response.body}");

    print("rescode=1212==-$session----$deviceId----${userDetail.userId}");

    var value = WorkoutHistoryModel.fromJson(jsonDecode(response.body));

    print("value=1212==-$session----$deviceId----${userDetail.userId}");

    checkLoginError(context, value.data!.error!);

    return value;
  } else {
    return null;
  }
}

checkLoginError(BuildContext context, String s) {
  if (s == "Please login first") {
    PrefData.setSession("");
    PrefData.setIsSignIn(false);
    Get.toNamed(Routes.signInRoute);
  }
}
