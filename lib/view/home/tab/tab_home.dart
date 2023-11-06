// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/models/model_all_challenges.dart';
import 'package:flutter_women_workout_ui/view/subscriptions/subscriptions_provider.dart';
import 'package:flutter_women_workout_ui/view/workout_category/workout_category_exercise_list.dart';
import 'package:flutter_women_workout_ui/view/workout_category/workout_sub_category_list.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/model_all_workout_category.dart';
import '../../../models/model_dummy_send.dart';
import '../../../models/setting_model.dart';
import '../../../models/userdetail_model.dart';
import '../../../routes/app_routes.dart';
import '../../../util/color_category.dart';
import '../../../util/constant_url.dart';
import '../../../util/constant_widget.dart';
import '../../../util/constants.dart';
import '../../../util/pref_data.dart';
import '../../../util/service_provider.dart';
import '../../../util/widgets.dart';
import '../../controller/controller.dart';
import '../../workout/widget_challenges_exercise_list.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHome createState() => _TabHome();
}

class _TabHome extends State<TabHome> with TickerProviderStateMixin {
  HomeController controller = Get.put(HomeController());
  String? imageUrl;
  var tdata;
  String firstname = "";

  // double? progress;
  // double? sliderProgress;

  // int? progressIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUser();
  }

  void getUser() async {
    // progressIndex = await PrefData.getProgressIndex();
    String s = await PrefData.getUserDetail();
    if (s.isNotEmpty) {
      UserDetail userDetail = await ConstantUrl.getUserDetail();

      setState(() {
        firstname = userDetail.firstName!;
        if (userDetail.image != null) {
          if (userDetail.image!.isNotEmpty) {
            imageUrl = userDetail.image!;
          }
        }
      });
    }
  }

  getProfileImage() {
    if (imageUrl != null) {
      return CachedNetworkImage(
        height: 40.h,
        width: 40.h,
        imageUrl: ConstantUrl.uploadUrl + imageUrl!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tdata = DateTime.now().hour;
    setStatusBarColor(bgDarkWhite);
    return Column(
      children: [
        ConstantWidget.getVerSpace(20.h),
        buildAppBar(),
        ConstantWidget.getVerSpace(25.h),
        Expanded(
          flex: 1,
          child: ListView(
            primary: true,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              ConstantWidget.getVerSpace(20.h),
              buildWorkout(),
              ConstantWidget.getVerSpace(20.h),
              buildWorkoutCategory(),
              ConstantWidget.getVerSpace(6.h),
              buildPlan(),
              ConstantWidget.getVerSpace(65.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGoodMorningWidget(var time) {
    if (time < 12) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstantWidget.getMultilineCustomFont(
              "${"Good Morning,".tr} ${firstname}!", 15.sp, descriptionColor,
              fontWeight: FontWeight.w500, txtHeight: 1.46.h),
          ConstantWidget.getTextWidget("Let’s Shape Yourself".tr, textColor,
              TextAlign.start, FontWeight.w700, 28.sp),
        ],
      );
    } else if (time < 17) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstantWidget.getMultilineCustomFont(
              "${"Good Afternoon,".tr} ${firstname}!", 15.sp, descriptionColor,
              fontWeight: FontWeight.w500, txtHeight: 1.46.h),
          ConstantWidget.getTextWidget("Let’s Shape Yourself".tr, textColor,
              TextAlign.start, FontWeight.w700, 28.sp),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstantWidget.getMultilineCustomFont(
              "${"Good Evening,".tr} ${firstname}!", 15.sp, descriptionColor,
              fontWeight: FontWeight.w500, txtHeight: 1.46.h),
          ConstantWidget.getTextWidget("Let’s Shape Yourself".tr, textColor,
              TextAlign.start, FontWeight.w700, 28.sp),
        ],
      );
    }
  }

  Widget buildAppBar() {
    return ConstantWidget.getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildGoodMorningWidget(tdata),
          // getSvgImage("menu.svg", width: 24.h, height: 24.h),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.editProfileRoute)!.then((value) {
                    setState(() {
                      getUser();
                    });
                  });
                },
                child: ClipOval(
                  child: Material(
                    child: getProfileImage(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Column buildPlan() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ConstantWidget.getPaddingWidget(
          EdgeInsets.symmetric(horizontal: 20.h),
          getCustomText("My Plan".tr, textColor, 1, TextAlign.start,
              FontWeight.w700, 20.sp),
        ),
        ConstantWidget.getVerSpace(12.h),
        Container(
          height: 169.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemCount: 1,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  controller.onChange(2.obs);
                },
                child: Container(
                  margin: EdgeInsetsDirectional.only(
                      end: 12.h, start: index == 0 ? 20.h : 0),
                  width: 374.w,
                  child: Column(
                    children: [
                      ConstantWidget.getVerSpace(11.h),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            height: 158.h,
                            decoration: BoxDecoration(
                                color: "FFF3D0".toColor(),
                                borderRadius: BorderRadius.circular(22.h)),
                            child: Row(
                              children: [
                                ConstantWidget.getHorSpace(20.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    getCustomText(
                                        "Custom Workout".tr,
                                        textColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w700,
                                        22.sp),
                                    ConstantWidget.getVerSpace(4.h),
                                    Container(
                                      width: 203.h,
                                      child: ConstantWidget.getMultilineCustomFont(
                                          "Add your custom plan by tapping to create a new plan"
                                              .tr,
                                          12.sp,
                                          descriptionColor,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.start,
                                          txtHeight: 1.25.h),
                                    ),
                                    ConstantWidget.getVerSpace(12.h),
                                    Row(
                                      children: [
                                        getCustomText(
                                            "Let’s Start".tr,
                                            textColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            16.sp),
                                        ConstantWidget.getHorSpace(6.h),
                                        getSvgImage("arrow_right.svg",
                                            height: 24.h,
                                            width: 24.h,
                                            color: textColor)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              // top: -60.h,
                              // right: 15.h,
                              height: 263.h,
                              width: 170.h,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: 15.h, bottom: 15.h),
                                child: getAssetImage(
                                  "plan.png",
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  FutureBuilder<ModelSetting> buildWorkoutCategory() {
    return FutureBuilder<ModelSetting>(
      future: getSetting(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ModelSetting? modelSetting = snapshot.data;
          if (modelSetting!.data.success == 1) {
            Setting setting = modelSetting.data.setting;
            if (setting.category == "1") {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstantWidget.getPaddingWidget(
                    EdgeInsets.symmetric(horizontal: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getCustomText(
                          "Workout Categories".tr,
                          textColor,
                          1,
                          TextAlign.start,
                          FontWeight.w700,
                          20.sp,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.workoutCategoryListRoute);
                          },
                          child: getCustomText("See all".tr, descriptionColor,
                              1, TextAlign.end, FontWeight.w500, 15.sp),
                        )
                      ],
                    ),
                  ),
                  ConstantWidget.getVerSpace(12.h),
                  FutureBuilder<ModelAllWorkout?>(
                    future: getYogaWorkout(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        ModelAllWorkout? modelWorkout = snapshot.data;

                        if (modelWorkout!.data.success == 1) {
                          List<Category>? workoutList =
                              modelWorkout.data.category;

                          return Container(
                            height: 209.h,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: workoutList.length,
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Category _modelWorkoutList =
                                      workoutList[index];

                                  ModelDummySend dummySend = new ModelDummySend(
                                      _modelWorkoutList.categoryId,
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en-US'
                                          ? _modelWorkoutList.category
                                          : _modelWorkoutList.categoryAr,
                                      ConstantUrl.urlGetWorkoutExercise,
                                      ConstantUrl.varCatId,
                                      getCellColor(index),
                                      _modelWorkoutList.image,
                                      true,
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en-US'
                                          ? _modelWorkoutList.description
                                          : _modelWorkoutList.descriptionAr,
                                      CATEGORY_WORKOUT);

                                  return Container(
                                    margin: EdgeInsetsDirectional.only(
                                        end: 12.h,
                                        start: index == 0 ? 20.h : 0),
                                    height: 209.h,
                                    width: 177.h,
                                    child: Column(
                                      children: [
                                        ConstantWidget.getVerSpace(13.h),
                                        InkWell(
                                          onTap: () {
                                            print(
                                                'asdkljasd ${_modelWorkoutList.isPro}');
                                            print(
                                                'asdkljasd ${context.read<SubscriptionsProvider>().isSubscribed}');
                                            if (_modelWorkoutList.isPro &&
                                                !context
                                                    .read<
                                                        SubscriptionsProvider>()
                                                    .isSubscribed) {
                                              Get.toNamed(
                                                  Routes.subscriptionsRoute);
                                            } else {
                                              if (!_modelWorkoutList
                                                  .hasChildren) {
                                                Get.to(() =>
                                                    WorkoutCategoryExerciseList(
                                                        dummySend));
                                                return;
                                              }
                                              Get.to(
                                                  () => WorkoutSubCategoryList(
                                                        catId: _modelWorkoutList
                                                            .categoryId,
                                                      ));
                                            }
                                          },
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                height: 127.h,
                                                width: 177.h,
                                                decoration: BoxDecoration(
                                                  color: getCellColor(index),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          22.h),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  22.h)),
                                                  child: getAssetImage(
                                                      "shape_workout.png",
                                                      boxFit: BoxFit.fill,
                                                      height: 43.h,
                                                      width: 150.h,
                                                      color: getCellShapeColor(
                                                          index)),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Hero(
                                                    tag: "excersiseImage",
                                                    child: CachedNetworkImage(
                                                      height: 140.h,
                                                      width: 160.h,
                                                      imageUrl: ConstantUrl
                                                              .uploadUrl +
                                                          _modelWorkoutList
                                                              .image,
                                                    ),
                                                  )),
                                              Visibility(
                                                visible:
                                                    _modelWorkoutList.isPro,
                                                child: Container(
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: accentColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(18),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          18))),
                                                  child: Text(
                                                    "Pro",
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ConstantWidget.getVerSpace(8.h),
                                        ConstantWidget.getMultilineCustomFont(
                                            Localizations.localeOf(context)
                                                        .languageCode ==
                                                    'en-US'
                                                ? _modelWorkoutList.category
                                                : _modelWorkoutList.categoryAr,
                                            18.sp,
                                            textColor,
                                            fontWeight: FontWeight.w600,
                                            txtHeight: 1.1.h,
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return getNoData(context);
                        }
                      } else {
                        return Container(
                          height: 209.h,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      right: 12.h, left: index == 0 ? 20.h : 0),
                                  height: 209.h,
                                  width: 177.h,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Column(
                                      children: [
                                        ConstantWidget.getVerSpace(13.h),
                                        Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Container(
                                              alignment: Alignment.bottomRight,
                                              height: 127.h,
                                              width: 177.h,
                                              decoration: BoxDecoration(
                                                color: getCellColor(index),
                                                borderRadius:
                                                    BorderRadius.circular(22.h),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(22.h)),
                                                child: getAssetImage(
                                                    "shape_workout.png",
                                                    boxFit: BoxFit.fill,
                                                    height: 43.h,
                                                    width: 150.h,
                                                    color: getCellShapeColor(
                                                        index)),
                                              ),
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  height: 140.h,
                                                  width: 160.h,
                                                ))
                                          ],
                                        ),
                                        ConstantWidget.getVerSpace(8.h),
                                        ConstantWidget.getMultilineCustomFont(
                                            "", 18.sp, textColor,
                                            fontWeight: FontWeight.w600,
                                            txtHeight: 1.1.h,
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    },
                  )
                ],
              );
            }
          }
        } else if (snapshot.hasError) {
          Constants.showToast(snapshot.error.toString());
        } else {
          CircularProgressIndicator();
        }
        return Container();
      },
    );
  }

  FutureBuilder<Object?> buildWorkout() {
    return FutureBuilder<ModelSetting>(
      future: getSetting(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ModelSetting? modelSetting = snapshot.data;
          if (modelSetting!.data.success == 1) {
            Setting setting = modelSetting.data.setting;
            if (setting.challenges == "1") {
              return GetBuilder<HomeController>(
                init: HomeController(),
                builder: (controller) => Column(
                  children: [
                    FutureBuilder<ModelAllChallenge>(
                      future: getAllChallenge(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          ModelAllChallenge? _modelAllChallenge = snapshot.data;
                          if (_modelAllChallenge!.data.success == 1) {
                            List<Challenge>? challengesList =
                                _modelAllChallenge.data.challenges;
                            double progress = (_modelAllChallenge
                                        .data
                                        .challenges[
                                            controller.progressIndex.value]
                                        .totaldayscompleted *
                                    100) /
                                _modelAllChallenge
                                    .data
                                    .challenges[controller.progressIndex.value]
                                    .totaldays;
                            if (progress > 100) {
                              progress = 100;
                            }
                            double sliderProgress = (_modelAllChallenge
                                    .data
                                    .challenges[controller.progressIndex.value]
                                    .totaldayscompleted) /
                                _modelAllChallenge
                                    .data
                                    .challenges[controller.progressIndex.value]
                                    .totaldays;
                            List<Container>? imageSliders = (challengesList !=
                                    null)
                                ? challengesList.map((item) {
                                    return Container(
                                      child: FutureBuilder<PaletteGenerator?>(
                                        builder: (context, snapshot) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                right: 12.h, top: 18.h),
                                            height: 194.h,
                                            width: 348.w,
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.onProgressChange(
                                                        challengesList
                                                            .indexOf(item)
                                                            .obs);

                                                    Get.to(() =>
                                                            WidgetChallengesExerciseList(
                                                              item,
                                                              bgColor: getWorkoutColor(
                                                                  int.parse(item
                                                                      .challengesId)),
                                                            ))!
                                                        .then((value) => {
                                                              controller
                                                                  .onProgressChange(
                                                                      0.obs)
                                                            });
                                                  },
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .bottomEnd,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        width: 348.w,
                                                        height: 182.h,
                                                        decoration: BoxDecoration(
                                                            color: getWorkoutColor(
                                                                int.parse(item
                                                                    .challengesId)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22.h)),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    start:
                                                                        20.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ConstantWidget
                                                                .getVerSpace(
                                                                    20.h),
                                                            getCustomText(
                                                                Localizations.localeOf(context)
                                                                            .languageCode ==
                                                                        'en-US'
                                                                    ? item
                                                                        .challengesName
                                                                    : item
                                                                        .challengesNameAr,
                                                                textColor,
                                                                2,
                                                                TextAlign.start,
                                                                FontWeight.w700,
                                                                20.sp,
                                                                resizeText:
                                                                    true),
                                                            ConstantWidget
                                                                .getVerSpace(
                                                                    10.h),
                                                            Row(
                                                              children: [
                                                                getSvgImage(
                                                                    "Clock.svg",
                                                                    height:
                                                                        14.h,
                                                                    width:
                                                                        14.h),
                                                                SizedBox(
                                                                  width: 7.h,
                                                                ),
                                                                getCustomText(
                                                                    "${item.totalweek} ${'week'.tr}",
                                                                    descriptionColor,
                                                                    1,
                                                                    TextAlign
                                                                        .start,
                                                                    FontWeight
                                                                        .w600,
                                                                    14.sp)
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerEnd,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .horizontal(
                                                            right:
                                                                Radius.circular(
                                                                    22.h),
                                                          ),
                                                          child: getAssetImage(
                                                              "shape1.png",
                                                              boxFit:
                                                                  BoxFit.fill,
                                                              height: 176.h,
                                                              width: 190.h),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          height: 200.h,
                                                          width: 160.h,
                                                          // bottom: -3.h,
                                                          // right: 19.h,
                                                          child: Hero(
                                                            tag: item.image,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .only(
                                                                          end: 19
                                                                              .h),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: ConstantUrl
                                                                        .uploadUrl +
                                                                    item.image,
                                                              ),
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList()
                                : null;
                            return Column(
                              children: [
                                ConstantWidget.getPaddingWidget(
                                  EdgeInsets.symmetric(horizontal: 20.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.h),
                                        decoration: BoxDecoration(
                                            color: lightOrange,
                                            borderRadius:
                                                BorderRadius.circular(22.h)),
                                        child: Column(
                                          children: [
                                            ConstantWidget.getVerSpace(19.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ConstantWidget
                                                    .getMultilineCustomFont(
                                                        "Your Progress in this Week"
                                                            .tr,
                                                        20.sp,
                                                        textColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        txtHeight: 1.5.h),
                                                CircularPercentIndicator(
                                                    radius: 30.h,
                                                    lineWidth: 4.h,
                                                    percent:
                                                        (sliderProgress > 1)
                                                            ? 1
                                                            : sliderProgress,
                                                    center: Text(
                                                        "${progress.toInt()}%",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14.sp,
                                                            foreground: Paint()
                                                              ..shader =
                                                                  LinearGradient(
                                                                      colors: [
                                                                    Color(
                                                                        0xFFFF4E1B),
                                                                    Color(
                                                                        0xFFFF7F37),
                                                                  ],
                                                                      stops: [
                                                                    0.0,
                                                                    1.0
                                                                  ]).createShader(
                                                                      Rect.fromLTWH(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0)))),
                                                    // linearGradient: LinearGradient(
                                                    //     begin: Alignment.topCenter,
                                                    //     end: Alignment.bottomCenter,
                                                    //     colors: <Color>[
                                                    //       Color(0xFFFF4E1B),
                                                    //       Color(0xFFFF7F37)
                                                    //     ],
                                                    //     stops: [
                                                    //       0.0,
                                                    //       1.0
                                                    //     ],
                                                    //   tileMode: TileMode.mirror
                                                    // ),
                                                    progressColor:
                                                        Color(0xFFFF4E1B),
                                                    backgroundColor:
                                                        Colors.white,
                                                    rotateLinearGradient: true,
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round)
                                              ],
                                            ),
                                            ConstantWidget.getVerSpace(19.h),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ConstantWidget.getVerSpace(12.h),
                                ConstantWidget.getPaddingWidget(
                                  EdgeInsets.symmetric(horizontal: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      getCustomText(
                                        "Workout".tr,
                                        textColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w700,
                                        20.sp,
                                      ),
                                      getCustomText(
                                          "See all".tr,
                                          descriptionColor,
                                          1,
                                          TextAlign.end,
                                          FontWeight.w500,
                                          15.sp)
                                    ],
                                  ),
                                ),
                                ConstantWidget.getVerSpace(12.h),
                                CarouselSlider(
                                    items: imageSliders,
                                    options: CarouselOptions(
                                      height: 200.h,
                                      viewportFraction: 0.9.h,
                                      enlargeCenterPage: false,
                                    ))
                              ],
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Column(
                            children: [
                              ConstantWidget.getPaddingWidget(
                                EdgeInsets.symmetric(horizontal: 20.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.h),
                                        decoration: BoxDecoration(
                                            color: lightOrange,
                                            borderRadius:
                                                BorderRadius.circular(22.h)),
                                        child: Column(
                                          children: [
                                            ConstantWidget.getVerSpace(19.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ConstantWidget
                                                    .getMultilineCustomFont(
                                                        "Your Progress in this Week"
                                                            .tr,
                                                        20.sp,
                                                        textColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        txtHeight: 1.5.h),
                                                CircularPercentIndicator(
                                                    radius: 30.h,
                                                    lineWidth: 4.h,
                                                    percent: 0,
                                                    center: Text("${0}%",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14.sp,
                                                            foreground: Paint()
                                                              ..shader = LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFFFF4E1B),
                                                                    Color(
                                                                        0xFFFF7F37),
                                                                  ],
                                                                  stops: [
                                                                    0.0,
                                                                    1.0
                                                                  ]).createShader(
                                                                  Rect.fromLTWH(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0)))),
                                                    linearGradient:
                                                        LinearGradient(
                                                            begin: Alignment
                                                                .center,
                                                            end:
                                                                Alignment
                                                                    .center,
                                                            colors: <Color>[
                                                          Color(0xFFFF4E1B),
                                                          Color(0xFFFF7F37)
                                                        ],
                                                            stops: [
                                                          0.0,
                                                          1.0
                                                        ]),
                                                    backgroundColor:
                                                        Colors.white,
                                                    rotateLinearGradient: true,
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round)
                                              ],
                                            ),
                                            ConstantWidget.getVerSpace(19.h),
                                          ],
                                        ),
                                      ),
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                    ),
                                  ],
                                ),
                              ),
                              ConstantWidget.getVerSpace(12.h),
                              ConstantWidget.getPaddingWidget(
                                EdgeInsets.symmetric(horizontal: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getCustomText(
                                      "Workout".tr,
                                      textColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w700,
                                      20.sp,
                                    ),
                                    getCustomText(
                                        "See all".tr,
                                        descriptionColor,
                                        1,
                                        TextAlign.end,
                                        FontWeight.w500,
                                        15.sp)
                                  ],
                                ),
                              ),
                              ConstantWidget.getVerSpace(12.h),
                              CarouselSlider(
                                  items: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 12.h, top: 18.h),
                                        alignment: Alignment.topLeft,
                                        width: 348.w,
                                        height: 182.h,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(22.h)),
                                      ),
                                    )
                                  ],
                                  options: CarouselOptions(
                                    height: 200.h,
                                    viewportFraction: 0.9.h,
                                    enlargeCenterPage: false,
                                  ))
                            ],
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            }
          }
        } else if (snapshot.hasError) {
          Constants.showToast(snapshot.error.toString());
        } else {
          CircularProgressIndicator();
        }
        return Container();
      },
    );
  }

  Future<PaletteGenerator?> updatePaletteGenerator(String image) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      Image.network(ConstantUrl.uploadUrl + image).image,
    );
    return paletteGenerator;
  }
}
