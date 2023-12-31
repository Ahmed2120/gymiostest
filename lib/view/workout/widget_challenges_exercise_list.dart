import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/models/model_exercise_week.dart';
import 'package:flutter_women_workout_ui/models/model_exrecise_days.dart';
import 'package:flutter_women_workout_ui/util/constant_url.dart';
import 'package:flutter_women_workout_ui/util/constants.dart';
import 'package:flutter_women_workout_ui/view/workout/widget_workout_exercise_list.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/model_all_challenges.dart';
import '../../util/color_category.dart';
import '../../util/constant_widget.dart';
import '../../util/service_provider.dart';
import '../../util/widgets.dart';

class WidgetChallengesExerciseList extends StatefulWidget {
  final Color? bgColor;

  final Challenge _modelWorkoutList;

  WidgetChallengesExerciseList(this._modelWorkoutList, {this.bgColor});

  @override
  _WidgetChallengesExerciseList createState() =>
      _WidgetChallengesExerciseList();
}

class _WidgetChallengesExerciseList
    extends State<WidgetChallengesExerciseList> {
  int openWeek = 0;
  int lastWeek = 1, lastDay = 1;

  Day? days;

  int totalAllDays = 0;
  String weekId = "";
  String lastDayId = "";
  Week? week;
  String? days_id;
  String? week_id;
  List selectedItemsArr = [];
  List<Day> dayList = [];

  String id = "0";
  // final BannerAd myBanner = BannerAd(
  //   adUnitId: Platform.isAndroid
  //       ? 'ca-app-pub-3940256099942544/6300978111'
  //       : "ca-app-pub-3940256099942544/2934735716",
  //   size: AdSize.banner,
  //   request: AdRequest(),
  //   listener: BannerAdListener(
  //     // Called when an ad is successfully received.
  //     onAdLoaded: (Ad ad) => print('Ad loaded.'),
  //     // Called when an ad request failed.
  //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //       // Dispose the ad here to free resources.
  //       ad.dispose();
  //       print('Ad failed to load: $error');
  //     },
  //     // Called when an ad opens an overlay that covers the screen.
  //     onAdOpened: (Ad ad) => print('Ad opened.'),
  //     // Called when an ad removes an overlay that covers the screen.
  //     onAdClosed: (Ad ad) => print('Ad closed.'),
  //     // Called when an impression occurs on the ad.
  //     onAdImpression: (Ad ad) => print('Ad impression.'),
  //   ),
  // );

  // @override
  // void initState() {
    // TODO: implement initState
    // super.initState();
    // myBanner.load();
  // }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: getColorStatusBar(widget.bgColor),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            bottom: true,
            child: Container(
              height: double.infinity,
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      primary: true,
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 312.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstantWidget.getPaddingWidget(
                                    EdgeInsets.symmetric(horizontal: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        getCustomText(
                                            Localizations.localeOf(context)
                                                        .languageCode ==
                                                    'en-US'
                                                ? widget._modelWorkoutList
                                                    .challengesName
                                                : widget._modelWorkoutList
                                                    .challengesNameAr,
                                            textColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w700,
                                            20.sp),
                                        Wrap(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: '#FDE5DC'.toColor(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.h),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: "#33ACB6B5"
                                                            .toColor(),
                                                        blurRadius: 32,
                                                        offset: Offset(-2, 5))
                                                  ]),
                                              child: Row(
                                                children: [
                                                  getSvgImage(
                                                      "clock_orange.svg",
                                                      height: 19.h,
                                                      width: 19.h),
                                                  ConstantWidget.getHorSpace(
                                                      5.h),
                                                  getCustomText(
                                                      "${widget._modelWorkoutList.totalweek} ${'week'.tr}",
                                                      accentColor,
                                                      1,
                                                      TextAlign.start,
                                                      FontWeight.w600,
                                                      14.sp)
                                                ],
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 14.h,
                                                  vertical: 9.h),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  ConstantWidget.getVerSpace(20.h),
                                  FutureBuilder(
                                    future: getChallengeWeek(context,
                                        widget._modelWorkoutList.challengesId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        ModelExerciseWeek? challengeWeekModel =
                                            snapshot.data as ModelExerciseWeek?;
                                        if (challengeWeekModel!.data.success ==
                                            1) {
                                          List<Week>? weekList =
                                              challengeWeekModel.data.week;

                                          // List<ModelExerciseDays> modelExercise =
                                          //     getChallengeDay(context,
                                          //             weekList[0].weekId) as List<ModelExerciseDays>;
                                          //
                                          // id = modelExercise[0].data.days[0].daysId;
                                          getChallengeDay(
                                                  context, weekList[0].weekId)
                                              .then((value) {
                                            id = value!.data.days[0].daysId;
                                            print("idvalue--------${id}");
                                          });

                                          return ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: weekList.length,
                                            itemBuilder:
                                                (context, weekPosition) {
                                              Week weekModel =
                                                  weekList[weekPosition];

                                              if (lastWeek ==
                                                  (weekPosition + 1)) {
                                                totalAllDays =
                                                    weekModel.totaldays;
                                                weekId = weekModel.weekId;
                                                week = weekModel;
                                              }

                                              // weekList.forEach((element) {
                                              //   print(
                                              //       "completed-------${element.isCompleted}");
                                              //   // if(element.isCompleted == 0){
                                              //   //   print("weekposition------------${weekPosition}");
                                              //   //   openWeek = weekPosition;
                                              //   // }
                                              // });

                                              if (openWeek == weekPosition) {
                                                return ConstantWidget
                                                    .getPaddingWidget(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.h),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 20.h),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.h,
                                                            vertical: 20.h),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  containerShadow,
                                                              blurRadius: 32,
                                                              offset:
                                                                  Offset(-2, 5))
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.h)),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            getCustomText(
                                                                "${Localizations.localeOf(context).languageCode == 'en-US' ? weekModel.weekName : weekModel.weekNameAr}",
                                                                textColor,
                                                                1,
                                                                TextAlign.start,
                                                                FontWeight.w700,
                                                                17.sp),
                                                            getSvgImage(
                                                                "arrow_up.svg",
                                                                height: 24.h,
                                                                width: 24.h)
                                                          ],
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                        ),
                                                        ConstantWidget
                                                            .getVerSpace(20.h),
                                                        FutureBuilder<
                                                            ModelExerciseDays?>(
                                                          future:
                                                              getChallengeDay(
                                                                  context,
                                                                  weekModel
                                                                      .weekId),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              ModelExerciseDays?
                                                                  challengeWeekModel =
                                                                  snapshot.data;
                                                              if (challengeWeekModel!
                                                                      .data
                                                                      .success ==
                                                                  1) {
                                                                dayList =
                                                                    challengeWeekModel
                                                                        .data
                                                                        .days;

                                                                if (weekModel
                                                                        .isCompleted ==
                                                                    0) {
                                                                  dayList =
                                                                      challengeWeekModel
                                                                          .data
                                                                          .days;
                                                                  selectedItemsArr =
                                                                      dayList.where(
                                                                          (element) {
                                                                    return element
                                                                            .isCompleted ==
                                                                        0;
                                                                  }).toList();
                                                                  if (selectedItemsArr
                                                                          .length >
                                                                      0) {
                                                                    days_id =
                                                                        selectedItemsArr[0]
                                                                            .daysId;
                                                                  }
                                                                }

                                                                if ((dayList
                                                                        .length >
                                                                    0)) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      if (week !=
                                                                              null &&
                                                                          days !=
                                                                              null) {
                                                                        if (days_id ==
                                                                            null) {
                                                                          Constants.showToast(
                                                                              "Week Complete. Please Select other week.");
                                                                        } else {
                                                                          sendToWorkoutList(
                                                                              context,
                                                                              lastDay,
                                                                              lastWeek,
                                                                              days!,
                                                                              week!,
                                                                              int.parse(days_id!),
                                                                              id);
                                                                        }
                                                                      }
                                                                    },
                                                                    child: GridView
                                                                        .builder(
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        Color
                                                                            txtColor =
                                                                            textColor;
                                                                        Color
                                                                            setColor =
                                                                            Colors.white;
                                                                        days =
                                                                            dayList[0];

                                                                        if (i !=
                                                                            dayList.length) {
                                                                          if (weekModel.isCompleted !=
                                                                              1) {
                                                                            if (i >
                                                                                0) {
                                                                              if (dayList[i - 1].isCompleted == 1) {
                                                                                setColor = textColor;
                                                                                txtColor = Colors.white;
                                                                                days = dayList[i];
                                                                                lastDay = i + 1;
                                                                                lastWeek = weekPosition + 1;
                                                                              }
                                                                            }
                                                                          }
                                                                        }

                                                                        return (i ==
                                                                                dayList.length)
                                                                            ? Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 13.h),
                                                                                decoration: BoxDecoration(color: "#FCF7DC".toColor(), borderRadius: BorderRadius.circular(16.h)),
                                                                                child: getAssetImage("trophy.png", color: weekModel.isCompleted == 1 ? null : Colors.grey),
                                                                              )
                                                                            : InkWell(
                                                                                onTap: () {},
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(color: (weekModel.isCompleted == 1 || dayList[i].isCompleted == 1) ? accentColor : setColor, border: (weekModel.isCompleted == 1 || dayList[i].isCompleted == 1) ? null : Border.all(color: subTextColor, width: 1.h), borderRadius: BorderRadius.circular(16.h)),
                                                                                  child: getCustomText((i + 1).toString(), (weekModel.isCompleted == 1 || dayList[i].isCompleted == 1) ? Colors.white : txtColor, 1, TextAlign.center, FontWeight.w700, 20.sp),
                                                                                ),
                                                                              );
                                                                      },
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              4,
                                                                          mainAxisExtent: 66
                                                                              .h,
                                                                          crossAxisSpacing: 23
                                                                              .h,
                                                                          mainAxisSpacing:
                                                                              23.h),
                                                                      itemCount:
                                                                          dayList.length +
                                                                              1,
                                                                      shrinkWrap:
                                                                          true,
                                                                      primary:
                                                                          false,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              } else {
                                                                return Container();
                                                              }
                                                            } else {
                                                              return SizedBox();
                                                              // return GridView
                                                              //     .builder(
                                                              //   itemBuilder:
                                                              //       (context,
                                                              //           i) {
                                                              //     Color
                                                              //         txtColor =
                                                              //         textColor;
                                                              //     Color
                                                              //         setColor =
                                                              //         Colors
                                                              //             .white;
                                                              //
                                                              //     return (i ==
                                                              //             dayList
                                                              //                 .length)
                                                              //         ? Shimmer
                                                              //             .fromColors(
                                                              //             baseColor: Colors
                                                              //                 .grey
                                                              //                 .shade300,
                                                              //             highlightColor: Colors
                                                              //                 .grey
                                                              //                 .shade100,
                                                              //             child:
                                                              //                 Container(
                                                              //               padding:
                                                              //                   EdgeInsets.symmetric(horizontal: 13.h, vertical: 13.h),
                                                              //               decoration:
                                                              //                   BoxDecoration(color: "#FCF7DC".toColor(), borderRadius: BorderRadius.circular(16.h)),
                                                              //               child:
                                                              //                   getAssetImage("trophy.png", color: weekModel.isCompleted == 1 ? null : Colors.grey),
                                                              //             ),
                                                              //           )
                                                              //         : InkWell(
                                                              //             onTap:
                                                              //                 () {},
                                                              //             child:
                                                              //                 Shimmer.fromColors(
                                                              //               baseColor:
                                                              //                   Colors.grey.shade300,
                                                              //               highlightColor:
                                                              //                   Colors.grey.shade100,
                                                              //               child:
                                                              //                   Container(
                                                              //                 alignment: Alignment.center,
                                                              //                 decoration: BoxDecoration(color: (weekModel.isCompleted == 1 || dayList[i].isCompleted == 1) ? accentColor : setColor, border: (weekModel.isCompleted == 1 || dayList[i].isCompleted == 1) ? null : Border.all(color: subTextColor, width: 1.h), borderRadius: BorderRadius.circular(16.h)),
                                                              //                 child: getCustomText((i + 1).toString(), (weekModel.isCompleted == 1 || dayList[i].isCompleted == 1) ? Colors.white : txtColor, 1, TextAlign.center, FontWeight.w700, 20.sp),
                                                              //               ),
                                                              //             ),
                                                              //           );
                                                              //   },
                                                              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              //       crossAxisCount:
                                                              //           4,
                                                              //       mainAxisExtent:
                                                              //           66.h,
                                                              //       crossAxisSpacing:
                                                              //           23.h,
                                                              //       mainAxisSpacing:
                                                              //           23.h),
                                                              //   itemCount: dayList
                                                              //           .length +
                                                              //       1,
                                                              //   shrinkWrap:
                                                              //       true,
                                                              //   primary: false,
                                                              // );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      openWeek = weekPosition;
                                                      selectedItemsArr.clear();
                                                    });
                                                  },
                                                  child: ConstantWidget
                                                      .getPaddingWidget(
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20.h),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        bottom: 20.h,
                                                      ),
                                                      height: 62.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.h),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.h),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    containerShadow,
                                                                blurRadius: 32,
                                                                offset: Offset(
                                                                    -2, 5))
                                                          ]),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 1,
                                                              child: getCustomText(
                                                                  "${Localizations.localeOf(context).languageCode == 'en-US' ? weekModel.weekName : weekModel.weekNameAr}",
                                                                  textColor,
                                                                  1,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .w700,
                                                                  17.sp)),
                                                          getSvgImage(
                                                              "arrow_down.svg",
                                                              height: 24.h,
                                                              width: 24.h)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: 6,
                                          itemBuilder: (context, weekPosition) {
                                            if (openWeek == weekPosition) {
                                              return ConstantWidget
                                                  .getPaddingWidget(
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.h),
                                                Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 20.h),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.h,
                                                            vertical: 20.h),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  containerShadow,
                                                              blurRadius: 32,
                                                              offset:
                                                                  Offset(-2, 5))
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.h)),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            getCustomText(
                                                                "",
                                                                textColor,
                                                                1,
                                                                TextAlign.start,
                                                                FontWeight.w700,
                                                                17.sp),
                                                            getSvgImage(
                                                                "arrow_up.svg",
                                                                height: 24.h,
                                                                width: 24.h)
                                                          ],
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                        ),
                                                        ConstantWidget
                                                            .getVerSpace(20.h),
                                                        FutureBuilder<
                                                            ModelExerciseDays?>(
                                                          future:
                                                              getChallengeDay(
                                                                  context,
                                                                  1.toString()),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              ModelExerciseDays?
                                                                  challengeWeekModel =
                                                                  snapshot.data;
                                                              if (challengeWeekModel!
                                                                      .data
                                                                      .success ==
                                                                  1) {
                                                                dayList =
                                                                    challengeWeekModel
                                                                        .data
                                                                        .days;

                                                                if ((dayList
                                                                        .length >
                                                                    0)) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      if (week !=
                                                                              null &&
                                                                          days !=
                                                                              null) {
                                                                        if (days_id ==
                                                                            null) {
                                                                          Constants.showToast(
                                                                              "Week Complete. Please Select other week.");
                                                                        } else {
                                                                          sendToWorkoutList(
                                                                              context,
                                                                              lastDay,
                                                                              lastWeek,
                                                                              days!,
                                                                              week!,
                                                                              int.parse(days_id!),
                                                                              id);
                                                                        }
                                                                      }
                                                                    },
                                                                    child: GridView
                                                                        .builder(
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        Color
                                                                            txtColor =
                                                                            textColor;
                                                                        Color
                                                                            setColor =
                                                                            Colors.white;
                                                                        days =
                                                                            dayList[0];

                                                                        return (i ==
                                                                                dayList.length)
                                                                            ? Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 13.h),
                                                                                decoration: BoxDecoration(color: "#FCF7DC".toColor(), borderRadius: BorderRadius.circular(16.h)),
                                                                                child: getAssetImage("trophy.png", color: Colors.grey),
                                                                              )
                                                                            : InkWell(
                                                                                onTap: () {},
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(color: setColor, border: Border.all(color: subTextColor, width: 1.h), borderRadius: BorderRadius.circular(16.h)),
                                                                                  child: getCustomText((i + 1).toString(), txtColor, 1, TextAlign.center, FontWeight.w700, 20.sp),
                                                                                ),
                                                                              );
                                                                      },
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              4,
                                                                          mainAxisExtent: 66
                                                                              .h,
                                                                          crossAxisSpacing: 23
                                                                              .h,
                                                                          mainAxisSpacing:
                                                                              23.h),
                                                                      itemCount:
                                                                          dayList.length +
                                                                              1,
                                                                      shrinkWrap:
                                                                          true,
                                                                      primary:
                                                                          false,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              } else {
                                                                return Container();
                                                              }
                                                            } else {
                                                              return getProgressDialog();
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return ConstantWidget
                                                  .getPaddingWidget(
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.h),
                                                Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      bottom: 20.h,
                                                    ),
                                                    height: 62.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.h),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.h),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  containerShadow,
                                                              blurRadius: 32,
                                                              offset:
                                                                  Offset(-2, 5))
                                                        ]),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                getCustomText(
                                                                    "",
                                                                    textColor,
                                                                    1,
                                                                    TextAlign
                                                                        .start,
                                                                    FontWeight
                                                                        .w700,
                                                                    17.sp)),
                                                        getSvgImage(
                                                            "arrow_down.svg",
                                                            height: 24.h,
                                                            width: 24.h)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 292.h,
                              decoration: getDecorationWithSide(
                                  radius: 22.h,
                                  bgColor: widget.bgColor,
                                  isBottomLeft: true,
                                  isBottomRight: true),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding:
                                    EdgeInsets.symmetric(horizontal: 120.h),
                                child: Hero(
                                    tag: widget._modelWorkoutList.image,
                                    child: Image.network(
                                        ConstantUrl.uploadUrl +
                                            widget._modelWorkoutList.image,
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            ConstantWidget.getPaddingWidget(
                              EdgeInsets.symmetric(horizontal: 20.h),
                              Column(
                                children: [
                                  ConstantWidget.getVerSpace(23.h),
                                  InkWell(
                                    onTap: () {
                                      onBackClicked();
                                    },
                                    child: getSvgImage("arrow_left.svg",
                                        width: 24.h, height: 24.h),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                  ConstantWidget.getVerSpace(20.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    child: ConstantWidget.getButtonWidget(
                        context, 'Start Workout'.tr, blueButton, () {
                      setStatusBarColor('#D6F4FF'.toColor());
                      if (week != null && days != null) {
                        if (days_id == null) {
                          Constants.showToast(
                              "Week Complete. Please Select other week.");
                        } else {
                          sendToWorkoutList(context, lastDay, lastWeek, days!,
                              week!, int.parse(days_id!), id);
                        }
                      }
                    }),
                  ),
                  ConstantWidget.getVerSpace(20.h),
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: AdWidget(ad: myBanner),
                  //   width: myBanner.size.width.toDouble(),
                  //   height: myBanner.size.height.toDouble(),
                  // ),
                  // ConstantWidget.getVerSpace(10.h),
                ],
              ),
            )),
      ),
      onWillPop: () async {
        onBackClicked();
        return false;
      },
    );
  }

  sendToWorkoutList(BuildContext context, int day, int week, Day days,
      Week weekModel, int days_id, String id) {
    Get.to(() => WidgetWorkoutExerciseList(
          widget._modelWorkoutList,
          day,
          week,
          days,
          weekModel,
          days_id,
          id,
          bgColor: widget.bgColor,
        ));
  }

  void onBackClicked() {
    Get.back();
    setStatusBarColor(bgDarkWhite);
  }
}
