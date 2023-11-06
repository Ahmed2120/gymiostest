import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/util/constant_url.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/model_discover.dart';
import '../../../models/model_dummy_send.dart';
import '../../../models/model_quick_workout.dart';
import '../../../models/model_stretches.dart';
import '../../../models/setting_model.dart';
import '../../../util/color_category.dart';
import '../../../util/constant_widget.dart';
import '../../../util/constants.dart';
import '../../../util/service_provider.dart';
import '../../../util/widgets.dart';
import '../../controller/controller.dart';
import '../../workout_category/workout_category_exercise_list.dart';

class TabDiscover extends StatefulWidget {
  @override
  _TabDiscover createState() => _TabDiscover();
}

class _TabDiscover extends State<TabDiscover> with TickerProviderStateMixin {
  ScrollController? _scrollViewController;
  bool isScrollingDown = false;

  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    super.initState();

    _scrollViewController = new ScrollController();
    _scrollViewController!.addListener(() {
      if (_scrollViewController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          setState(() {});
        }
      }

      if (_scrollViewController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          setState(() {});
        }
      }
    });
  }

  HomeController homeController = Get.find();

  @override
  void dispose() {
    _scrollViewController!.removeListener(() {});
    _scrollViewController!.dispose();
    try {
      if (animationController != null) {
        animationController!.dispose();
      }
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: bgDarkWhite,
      child: Column(
        children: [
          ConstantWidget.getVerSpace(20.h),
          buildAppBar(),
          ConstantWidget.getVerSpace(30.h),
          Expanded(
            flex: 1,
            child: ListView(
              primary: true,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                buildDiscoverList(),
                ConstantWidget.getVerSpace(30.h),
                buildWorkoutForYou(),
                ConstantWidget.getVerSpace(30.h),
                buildStretchList(),
                ConstantWidget.getVerSpace(60.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStretchList() {
    return FutureBuilder<ModelSetting>(
      future: getSetting(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ModelSetting? modelSetting = snapshot.data;
          if (modelSetting!.data.success == 1) {
            Setting setting = modelSetting.data.setting;
            if (setting.stretches == "1") {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.h),
                    child: getCustomText('Stretches'.tr, textColor, 1,
                        TextAlign.start, FontWeight.w700, 20.sp),
                  ),
                  ConstantWidget.getVerSpace(12.h),
                  FutureBuilder(
                    future: getAllStretch(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        ModelStretches? modelStretch =
                            snapshot.data! as ModelStretches?;
                        if (modelStretch!.data!.success == 1) {
                          List<Stretches> _quickWorkoutList =
                              modelStretch.data!.stretches!;
                          return ListView.builder(
                            padding: EdgeInsetsDirectional.only(
                                start: 20.h, end: 20.h),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: _quickWorkoutList.length,
                            itemBuilder: (context, index) {
                              Stretches _modelQuickWorkout =
                                  _quickWorkoutList[index];
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animationController!,
                                  curve: Curves.easeInOut,
                                ),
                              );
                              animationController!.forward();
                              return InkWell(
                                onTap: () {
                                  ModelDummySend dummySend = new ModelDummySend(
                                      _modelQuickWorkout.stretchesId!,
                                      (Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en-US'
                                          ? _modelQuickWorkout.stretches
                                          : _modelQuickWorkout.stretchesAr)!,
                                      ConstantUrl.urlGetStretchesExercise,
                                      ConstantUrl.varStretchesId,
                                      getStretchesColor(index),
                                      _modelQuickWorkout.image!,
                                      true,
                                      _modelQuickWorkout.description!,
                                      STRETCH_WORKOUT);
                                  Get.to(() =>
                                      WorkoutCategoryExerciseList(dummySend));
                                },
                                child: AnimatedBuilder(
                                  animation: animationController!,
                                  builder: (context, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: Transform(
                                        transform: Matrix4.translationValues(
                                            0.0,
                                            50 * (1.0 - animation.value),
                                            0.0),
                                        child: Container(
                                            margin: EdgeInsetsDirectional.only(
                                                bottom: 12.h),
                                            height: 81.h,
                                            decoration: BoxDecoration(
                                                color: getStretchesColor(index),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        22.h)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.h,
                                                vertical: 4.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ConstantWidget
                                                    .getMultilineCustomFont(
                                                        (Localizations.localeOf(
                                                                        context)
                                                                    .languageCode ==
                                                                'en-US'
                                                            ? _modelQuickWorkout
                                                                .stretches
                                                            : _modelQuickWorkout
                                                                .stretchesAr)!,
                                                        17.sp,
                                                        textColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        txtHeight: 1.29.h),
                                                Hero(
                                                    tag: _modelQuickWorkout
                                                        .image!,
                                                    child: Image.network(
                                                        ConstantUrl.uploadUrl +
                                                            _modelQuickWorkout
                                                                .image!,
                                                        width: 88.h))
                                              ],
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Curves.easeInOut,
                              ),
                            );
                            animationController!.forward();
                            return AnimatedBuilder(
                              animation: animationController!,
                              builder: (context, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: Transform(
                                    transform: Matrix4.translationValues(
                                        0.0, 50 * (1.0 - animation.value), 0.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                          margin: EdgeInsets.only(bottom: 12.h),
                                          height: 81.h,
                                          decoration: BoxDecoration(
                                              color: getStretchesColor(index),
                                              borderRadius:
                                                  BorderRadius.circular(22.h)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.h, vertical: 4.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ConstantWidget.getMultilineCustomFont(
                                                  "_modelQuickWorkout.stretches!",
                                                  17.sp,
                                                  textColor,
                                                  fontWeight: FontWeight.w700,
                                                  txtHeight: 1.29.h),
                                              Container(width: 88.h)
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
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

  Widget buildWorkoutForYou() {
    return FutureBuilder<ModelSetting>(
      future: getSetting(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ModelSetting? modelSetting = snapshot.data;
          if (modelSetting!.data.success == 1) {
            Setting setting = modelSetting.data.setting;
            if (setting.quickworkout == "1") {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.h),
                    child: getCustomText('Workout For You'.tr, textColor, 1,
                        TextAlign.start, FontWeight.w700, 20.sp),
                  ),
                  ConstantWidget.getVerSpace(12.h),
                  FutureBuilder(
                    future: getAllYogaStyleWorkout(
                      context,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        ModelQuickWorkout? _quickWorkout =
                            snapshot.data! as ModelQuickWorkout?;
                        if (_quickWorkout!.data!.success == 1) {
                          List<Quickworkout>? _quickWorkoutList =
                              _quickWorkout.data!.quickworkout;
                          return Container(
                            height: 199.h,
                            child: ListView.builder(
                              itemCount: _quickWorkoutList!.length,
                              primary: false,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Quickworkout _modelQuickWorkout =
                                    _quickWorkoutList[index];
                                return InkWell(
                                  onTap: () {
                                    ModelDummySend dummySend =
                                        new ModelDummySend(
                                            _modelQuickWorkout.quickworkoutId!,
                                            (Localizations.localeOf(context)
                                                        .languageCode ==
                                                    'en-US'
                                                ? _modelQuickWorkout
                                                    .quickworkout
                                                : _modelQuickWorkout
                                                    .quickworkoutAr)!,
                                            ConstantUrl
                                                .urlGetQuickWorkoutExercise,
                                            ConstantUrl.varQuickWorkoutId,
                                            getQuickWorkoutColor(index),
                                            _modelQuickWorkout.image!,
                                            true,
                                            _modelQuickWorkout.desc!,
                                            QUICK_WORKOUT);

                                    Get.to(() =>
                                        WorkoutCategoryExerciseList(dummySend));
                                  },
                                  child: Container(
                                    margin: EdgeInsetsDirectional.only(
                                        end: 20.h,
                                        start: index == 0 ? 20.h : 0),
                                    width: 348.h,
                                    padding: EdgeInsets.only(
                                        left: 37.h, right: 34.h),
                                    decoration: BoxDecoration(
                                        color: getQuickWorkoutColor(index),
                                        borderRadius:
                                            BorderRadius.circular(22.h)),
                                    child: Row(
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Container(
                                              width: 95.h,
                                              margin: EdgeInsets.only(
                                                  top: 30.h, bottom: 27.h),
                                              decoration: BoxDecoration(
                                                  color:
                                                      getQuickWorkoutShapeColor(
                                                          index),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  22.h),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  22.h))),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: ConstantWidget
                                                  .getPaddingWidget(
                                                EdgeInsets.only(
                                                    top: 16.h, bottom: 27.h),
                                                Image.network(
                                                  ConstantUrl.uploadUrl +
                                                      _modelQuickWorkout.image
                                                          .toString(),
                                                  width: 100.h,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        ConstantWidget.getHorSpace(34.h),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ConstantWidget.getMultilineCustomFont(
                                                  (Localizations.localeOf(
                                                                      context)
                                                                  .languageCode ==
                                                              'en-US'
                                                          ? _modelQuickWorkout
                                                              .quickworkout
                                                          : _modelQuickWorkout
                                                              .quickworkoutAr) ??
                                                      '',
                                                  20.sp,
                                                  textColor,
                                                  fontWeight: FontWeight.w700,
                                                  txtHeight: 1.5.h),
                                              // ConstantWidget.getVerSpace(8.h),
                                              // Row(
                                              //   children: [
                                              //     getSvgImage("Clock.svg",
                                              //         width: 14.h, height: 14.h),
                                              //     ConstantWidget.getHorSpace(11.h),
                                              //     getCustomText("4 week", descriptionColor, 1,
                                              //         TextAlign.start, FontWeight.w600, 14.sp)
                                              //   ],
                                              // ),
                                              // ConstantWidget.getVerSpace(12.h),
                                              // Row(
                                              //   children: [
                                              //     getSvgImage("dumble.svg",
                                              //         height: 16.h, width: 16.h),
                                              //     ConstantWidget.getHorSpace(6.h),
                                              //     getCustomText(
                                              //         "14 exercise",
                                              //         descriptionColor,
                                              //         1,
                                              //         TextAlign.start,
                                              //         FontWeight.w600,
                                              //         14.sp)
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container(
                          height: 199.h,
                          child: ListView.builder(
                            itemCount: 3,
                            primary: false,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 20.h, left: index == 0 ? 20.h : 0),
                                  width: 348.h,
                                  padding:
                                      EdgeInsets.only(left: 37.h, right: 34.h),
                                  decoration: BoxDecoration(
                                      color: getQuickWorkoutColor(index),
                                      borderRadius:
                                          BorderRadius.circular(22.h)),
                                  child: Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          Container(
                                            width: 95.h,
                                            margin: EdgeInsets.only(
                                                top: 30.h, bottom: 27.h),
                                            decoration: BoxDecoration(
                                                color:
                                                    getQuickWorkoutShapeColor(
                                                        index),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(22.h),
                                                    bottomLeft:
                                                        Radius.circular(22.h))),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child:
                                                ConstantWidget.getPaddingWidget(
                                                    EdgeInsets.only(
                                                        top: 16.h,
                                                        bottom: 27.h),
                                                    Container(
                                                      width: 100.h,
                                                    )),
                                          )
                                        ],
                                      ),
                                      ConstantWidget.getHorSpace(34.h),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ConstantWidget
                                                .getMultilineCustomFont(
                                                    '', 20.sp, textColor,
                                                    fontWeight: FontWeight.w700,
                                                    txtHeight: 1.5.h),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
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

  FutureBuilder<Object?> buildDiscoverList() {
    return FutureBuilder<ModelSetting>(
      future: getSetting(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ModelSetting? modelSetting = snapshot.data;
          if (modelSetting!.data.success == 1) {
            Setting setting = modelSetting.data.setting;
            if (setting.discover == "1") {
              return FutureBuilder(
                future: getAllDiscover(
                  context,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ModelDiscover? _modelDiscover =
                        snapshot.data! as ModelDiscover?;
                    if (_modelDiscover!.data.success == 1) {
                      List<Discover>? _discoverList =
                          _modelDiscover.data.discover;

                      return Container(
                        height: 290.h,
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: _discoverList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            Discover discover = _discoverList[index];
                            return Container(
                              margin: EdgeInsetsDirectional.only(
                                  end: 20.h, start: index == 0 ? 20.h : 0),
                              child: InkWell(
                                onTap: () {
                                  ModelDummySend dummySend = new ModelDummySend(
                                      discover.discoverId,
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en-US'
                                          ? discover.discover
                                          : discover.discoverAr,
                                      ConstantUrl.urlGetDiscoverExercise,
                                      ConstantUrl.varDiscoverId,
                                      getDiscoverWorkoutColor(index),
                                      discover.image,
                                      false,
                                      discover.description,
                                      DISCOVER_WORKOUT);

                                  Get.to(() =>
                                      WorkoutCategoryExerciseList(dummySend));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Column(
                                      children: [
                                        ConstantWidget.getVerSpace(35.h),
                                        Container(
                                          height: 255.h,
                                          width: 252.h,
                                          decoration: BoxDecoration(
                                              color: getDiscoverWorkoutColor(
                                                  index),
                                              borderRadius:
                                                  BorderRadius.circular(22.h)),
                                          alignment: Alignment.bottomLeft,
                                          padding: EdgeInsets.only(
                                              top: 48.88.h, right: 59.h),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(22.h)),
                                            child: getAssetImage(
                                                getDiscoverWorkoutShape(index)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                        child: Hero(
                                      tag: discover.image,
                                      child: Container(
                                        height: 290.h,
                                        width: 252.h,
                                        child: Image.network(
                                          ConstantUrl.uploadUrl +
                                              discover.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                    Positioned(
                                        child: Container(
                                      height: 113.h,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              textColor.withOpacity(0.0),
                                              textColor.withOpacity(0.56)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(22.h)),
                                      width: 252.h,
                                    )),
                                    Positioned(
                                      child: getCustomText(
                                          Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en-US'
                                              ? discover.discover
                                              : discover.discoverAr,
                                          Colors.white,
                                          2,
                                          TextAlign.center,
                                          FontWeight.w700,
                                          28.sp,
                                          resizeText: true,
                                          width: 200),
                                      bottom: 23.h,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container(
                      height: 290.h,
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 20.h, left: index == 0 ? 20.h : 0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(
                                    children: [
                                      ConstantWidget.getVerSpace(35.h),
                                      Container(
                                        height: 255.h,
                                        width: 252.h,
                                        decoration: BoxDecoration(
                                            color:
                                                getDiscoverWorkoutColor(index),
                                            borderRadius:
                                                BorderRadius.circular(22.h)),
                                        alignment: Alignment.bottomLeft,
                                        padding: EdgeInsets.only(
                                            top: 48.88.h, right: 59.h),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(22.h)),
                                          child: getAssetImage(
                                              getDiscoverWorkoutShape(index)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                      child: Container(
                                    height: 290.h,
                                    width: 252.h,
                                  )),
                                  Positioned(
                                      child: Container(
                                    height: 113.h,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            textColor.withOpacity(0.0),
                                            textColor.withOpacity(0.56)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(22.h)),
                                    width: 252.h,
                                  )),
                                  Positioned(
                                    child: getCustomText(
                                        "discover.discover",
                                        Colors.white,
                                        1,
                                        TextAlign.center,
                                        FontWeight.w700,
                                        28.sp),
                                    bottom: 23.h,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
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

  Widget buildAppBar() {
    return ConstantWidget.getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  child:
                      getSvgImage("arrow_left.svg", width: 24.h, height: 24.h),
                  onTap: () {
                    homeController.onChange(0.obs);
                  }),
              ConstantWidget.getHorSpace(12.h),
              getCustomText("Discover Workout".tr, textColor, 1,
                  TextAlign.start, FontWeight.w700, 22.sp)
            ],
          ),
        ],
      ),
    );
  }
}
