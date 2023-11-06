import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_women_workout_ui/view/signup/sign_up_page.dart';
import '../view/controller/controller.dart';
import '../../util/flutter_vertical_slider.dart';

import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

import 'models/guide_intro_model.dart';
import 'util/color_category.dart';
import 'util/constant_widget.dart';
import 'util/constants.dart';
import 'view/login/sign_in_page.dart';
import 'util/constant_url.dart';
import 'models/intensively_model.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPage createState() {
    return _IntroPage();
  }
}

class _IntroPage extends State<IntroPage> {
  double margin = 0;
  int selectIntensively = 0;
  PageController pageController = PageController();

  List<IntensivelyModel> timeInWeekList = ConstantUrl.getTimeInWeekModel();

  Future<bool> _requestPop() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ));

    return new Future.value(false);
  }

  IntroController controller = Get.put(IntroController());

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    setLbsValue();
    controller.sliderPosition = 0;
    controller.update();

    Timer(Duration(seconds: 1), () {
      setState(() {
        widgetList.add(getGender());
        widgetList.add(getAge());
        widgetList.add(heightWidget());
        widgetList.add(getWeight());
        widgetList.add(getTimeInWeek());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    margin = ConstantWidget.getWidthPercentSize(context, 2);

    return GestureDetector(
        child: WillPopScope(
            child: Scaffold(
              backgroundColor: bgDarkWhite,
              appBar: getNoneAppBar(context),
              body: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                        child: PageView.builder(
                      itemCount: widgetList.length,
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          controller.sliderPosition = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return widgetList.length > 0
                            ? widgetList[index]
                            : Container();
                      },
                    )),
                    Container(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: ConstantWidget.getPaddingWidget(
                        EdgeInsets.symmetric(horizontal: 20.h),
                        ConstantWidget.getButtonWidget(
                            context, "Next".tr, accentColor, () {
                          if ((controller.sliderPosition ==
                              (widgetList.length - 1))) {
                            actionDone();
                          } else {
                            actionNext();
                          }
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onWillPop: _requestPop),
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        });
  }

  actionNext() {
    setState(() {
      if (controller.sliderPosition < (widgetList.length - 1)) {
        controller.sliderPosition++;

        pageController.jumpToPage(controller.sliderPosition);
      }
    });
  }

  actionDone() {
    String gender;
    if (controller.genderPosition == 0) {
      gender = "Male";
    } else {
      gender = "Female";
    }

    GuideIntroModel introModel = new GuideIntroModel();
    introModel.gender = gender;
    introModel.age = controller.age.toString();
    introModel.height = controller.cm.toString();
    introModel.weight = controller.kg.toString();
    introModel.timeInWeek = timeInWeekList[controller.selectWeek.value].title;
    Get.to(() => SignUpPage(introModel));
  }

  actionPrevious() {
    setState(() {
      controller.sliderPosition--;
      if (controller.sliderPosition < 0) {
        _requestPop();
      } else {
        pageController.jumpToPage(controller.sliderPosition);
      }
    });
  }

  Widget getGender() {
    return ConstantWidget.getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20.h),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getIntroTitleBar(() {
            actionPrevious();
          }, "Select Your Gender".tr),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            height: 40.h,
          ),
          getGenderCell(setState, Constants.actionMale.obs, "male.svg",
              "Male".tr, "#DEF5FF".toColor()),
          SizedBox(
            height: 20.h,
          ),
          getGenderCell(setState, Constants.actionFemale.obs, "female.svg",
              "Female".tr, "#FFEBEB".toColor()),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  getGenderCell(
      var setState, RxInt position, String icon, String s, Color color) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        InkWell(
          onTap: () {
            controller.onChange(position);
          },
          child: Container(
            height: 177.h,
            width: 177.h,
            decoration: getDefaultDecoration(radius: 30.h, bgColor: color),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImage(icon, width: 60.h, height: 83.h),
                SizedBox(
                  height: 8.h,
                ),
                ConstantWidget.getTextWidget(
                    s, Colors.black, TextAlign.left, FontWeight.w700, 17.sp),
              ],
            ),
          ),
        ),
        GetX<IntroController>(
          init: IntroController(),
          builder: (controller) {
            return Positioned(
              top: 30.h,
              right: -8.h,
              child: controller.genderPosition == position
                  ? getSvgImage("check.svg", height: 24.h, width: 24.h)
                  : Container(),
            );
          },
        ),
      ],
    );
  }

  Widget getWeight() {
    return ConstantWidget.getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20.h),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getIntroTitleBar(() {
            actionPrevious();
          }, "What is your weight?".tr),
          ConstantWidget.getVerSpace(80.h),
          Align(
              alignment: Alignment.topCenter,
              child: GetX<IntroController>(
                init: IntroController(),
                builder: (controller) => NumberPicker(
                    itemWidth: 177.h,
                    itemHeight: 82.h,
                    value: controller.kg.toInt(),
                    minValue: 15,
                    maxValue: 200,
                    textStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: subTextColor,
                        fontFamily: Constants.fontsFamily),
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal:
                                BorderSide(color: accentColor, width: 1.h))),
                    selectedTextStyle: TextStyle(
                        fontSize: 36.sp,
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: Constants.fontsFamily),
                    step: 1,
                    haptics: true,
                    onChanged: (value) {
                      controller.kgChange(value.toInt());
                      setLbsValue();
                    }),
              )),
          ConstantWidget.getVerSpace(152.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      border: Border.all(color: accentColor, width: 1.h)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetX<IntroController>(
                        init: IntroController(),
                        builder: (controller) => ConstantWidget.getTextWidget(
                            controller.kg.toString(),
                            textColor,
                            TextAlign.end,
                            FontWeight.w700,
                            22.sp),
                      ),
                      ConstantWidget.getTextWidget('kg', textColor,
                          TextAlign.end, FontWeight.w500, 17.sp)
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20.h,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      border: Border.all(color: accentColor, width: 1.h)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetX<IntroController>(
                        init: IntroController(),
                        builder: (controller) => ConstantWidget.getTextWidget(
                            controller.lbs.toInt().toString(),
                            textColor,
                            TextAlign.end,
                            FontWeight.w700,
                            22.sp),
                      ),
                      ConstantWidget.getTextWidget('lbs', textColor,
                          TextAlign.end, FontWeight.w500, 17.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  setLbsValue() {
    double lbs = controller.kg.toDouble() * 2.205;

    controller.lbsChange(lbs.toInt());

    double total = (controller.cm / 2.54);
    double value = (total / 12);
    double value1 = (total - 12) * value.toInt();

    controller.ftChange(value.toInt(), value1.toInt());
  }

  Widget heightWidget() {
    return ConstantWidget.getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20.h),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getIntroTitleBar(() {
            actionPrevious();
          }, "How tall are you?".tr),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ConstantWidget.getTextWidget("7.0-", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                  SizedBox(
                    height: 59.h,
                  ),
                  ConstantWidget.getTextWidget("6.0-", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                  SizedBox(
                    height: 59.h,
                  ),
                  ConstantWidget.getTextWidget("5.0-", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                  SizedBox(
                    height: 59.h,
                  ),
                  ConstantWidget.getTextWidget("4.0-", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                ],
              ),
              ConstantWidget.getHorSpace(10.h),
              Container(
                  height: 334.h,
                  width: 101.h,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: "#17000000".toColor(),
                        blurRadius: 26,
                        offset: Offset(0, 4))
                  ], borderRadius: BorderRadius.circular(10.h)),
                  child: GetX<IntroController>(
                    init: IntroController(),
                    builder: (controller) => VerticalSlider(
                      onChanged: (value) {
                        controller.cmChange(value.toInt());
                        setLbsValue();
                      },
                      max: 230,
                      min: 100,
                      value: controller.cm.toDouble(),
                      width: 101.h,
                      activeTrackColor: "#FFF0EA".toColor(),
                      inactiveTrackColor: Colors.white,
                    ),
                  )),
              ConstantWidget.getHorSpace(10.h),
              Column(
                children: [
                  ConstantWidget.getTextWidget("-213cm", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                  SizedBox(
                    height: 59.h,
                  ),
                  ConstantWidget.getTextWidget("-183cm", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                  SizedBox(
                    height: 59.h,
                  ),
                  ConstantWidget.getTextWidget("-152cm", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                  SizedBox(
                    height: 59.h,
                  ),
                  ConstantWidget.getTextWidget("-123cm", subTextColor,
                      TextAlign.start, FontWeight.w600, 14),
                ],
              )
            ],
          ),
          ConstantWidget.getVerSpace(40.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 60.h,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: getDefaultDecoration(
                        borderColor: accentColor, radius: 22.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetX<IntroController>(
                          init: IntroController(),
                          builder: (controller) => ConstantWidget.getTextWidget(
                              controller.cm.toString(),
                              textColor,
                              TextAlign.end,
                              FontWeight.w700,
                              22.sp),
                        ),
                        ConstantWidget.getTextWidget('cm', textColor,
                            TextAlign.end, FontWeight.w500, 17.sp)
                      ],
                    ),
                  ),
                ),
              ),
              ConstantWidget.getHorSpace(20.h),
              Expanded(
                child: Container(
                  height: 60.h,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: getDefaultDecoration(
                        borderColor: accentColor, radius: 22.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetX<IntroController>(
                          init: IntroController(),
                          builder: (controller) => ConstantWidget.getTextWidget(
                              controller.ft.toString(),
                              textColor,
                              TextAlign.end,
                              FontWeight.w700,
                              22.sp),
                        ),
                        ConstantWidget.getTextWidget('ft', textColor,
                            TextAlign.end, FontWeight.w500, 17.sp),
                        GetX<IntroController>(
                          init: IntroController(),
                          builder: (controller) => ConstantWidget.getTextWidget(
                              controller.inch.toString(),
                              textColor,
                              TextAlign.end,
                              FontWeight.w700,
                              22.sp),
                        ),
                        ConstantWidget.getTextWidget('in', textColor,
                            TextAlign.end, FontWeight.w500, 17.sp)
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getAge() {
    return ConstantWidget.getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20.h),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getIntroTitleBar(() {
            actionPrevious();
          }, "How old are you?".tr),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            height: 80.h,
          ),
          Align(
              alignment: Alignment.topCenter,
              child: GetX<IntroController>(
                init: IntroController(),
                builder: (controller) {
                  return NumberPicker(
                    itemWidth: 177.h,
                    itemHeight: 82.h,
                    value: controller.age.toInt(),
                    minValue: 15,
                    maxValue: 90,
                    textStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: subTextColor,
                        fontFamily: Constants.fontsFamily),
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal:
                                BorderSide(color: accentColor, width: 1.h))),
                    selectedTextStyle: TextStyle(
                        fontSize: 36.sp,
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: Constants.fontsFamily),
                    step: 1,
                    haptics: true,
                    onChanged: (value) {
                      controller.ageChange(value.obs);
                    },
                  );
                },
              ))
        ],
      ),
    );
  }

  Widget getTimeInWeek() {
    return ConstantWidget.getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20.h),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          actionPrevious();
                        },
                        child: getSvgImage("arrow_left.svg",
                            height: 24.h, width: 24.h))
                  ],
                ),
                Positioned(
                    child: ConstantWidget.getPaddingWidget(
                  EdgeInsets.symmetric(horizontal: 55.h),
                  ConstantWidget.getMultilineCustomFont(
                      "How many time in week you exercise?".tr,
                      28.sp,
                      textColor,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center),
                ))
              ],
            ),
          ),
          ConstantWidget.getVerSpace(12.h),
          ConstantWidget.getVerSpace(40.h),
          Expanded(
            child: ListView.builder(
              itemCount: timeInWeekList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GetX<IntroController>(
                  init: IntroController(),
                  builder: (controller) => InkWell(
                    onTap: () {
                      controller.onWeekChange(index.obs);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 17.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 17.h, vertical: 17.h),
                      decoration: getDefaultDecoration(
                          bgColor: index == controller.selectWeek.value
                              ? lightOrange
                              : bgDarkWhite,
                          radius: 22.h,
                          borderColor: index == controller.selectWeek.value
                              ? null
                              : subTextColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstantWidget.getTextWidget(
                              timeInWeekList[index].title!,
                              textColor,
                              TextAlign.start,
                              FontWeight.w700,
                              22.sp),
                          ConstantWidget.getVerSpace(2.h),
                          ConstantWidget.getMultilineCustomFont(
                              timeInWeekList[index].desc!,
                              14.sp,
                              index == controller.selectWeek.value
                                  ? textColor
                                  : descriptionColor,
                              fontWeight: FontWeight.w500,
                              txtHeight: 1.57.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
