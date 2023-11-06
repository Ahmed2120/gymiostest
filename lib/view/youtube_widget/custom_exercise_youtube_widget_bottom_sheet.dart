import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_women_workout_ui/models/model_get_custom_plan_exercise.dart';
import 'package:flutter_women_workout_ui/util/color_category.dart';
import 'package:flutter_women_workout_ui/util/constant_widget.dart';
import 'package:flutter_women_workout_ui/util/constants.dart';
import 'package:flutter_women_workout_ui/util/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomExerciseYoutubeWidgetBottomSheet extends StatefulWidget {
  const CustomExerciseYoutubeWidgetBottomSheet(
      {Key? key, required this.exerciseDetail})
      : super(key: key);
  final Exercisedetail exerciseDetail;

  @override
  State<CustomExerciseYoutubeWidgetBottomSheet> createState() =>
      _CustomExerciseYoutubeWidgetBottomSheetState();
}

class _CustomExerciseYoutubeWidgetBottomSheetState
    extends State<CustomExerciseYoutubeWidgetBottomSheet> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.exerciseDetail.image,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        useHybridComposition: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: getDecorationWithSide(
          radius: 22.h,
          bgColor: bgDarkWhite,
          isTopLeft: true,
          isTopRight: true),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        primary: false,
        children: [
          ConstantWidget.getVerSpace(44.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ConstantWidget.getCustomTextWidget('Info'.tr,
                    Colors.black, 22.sp, FontWeight.w700, TextAlign.start, 1),
              ),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: getSvgImage("close.svg", height: 24.h, width: 24.h))
            ],
          ),
          ConstantWidget.getVerSpace(23.h),
// Image.network(
//   "${ConstantUrl.uploadUrl}${exerciseDetail.image}",
//   height: 332.h,
//   width: 233.h,
//   fit: BoxFit.fill,
// ),
          SizedBox(
            height: 332.h,
            width: 233.h,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          ConstantWidget.getVerSpace(16.h),
          getCustomText("How to perform?".tr, textColor, 1, TextAlign.start,
              FontWeight.w700, 20.sp),
          ConstantWidget.getVerSpace(13.h),
          HtmlWidget(
            Constants.decode(widget.exerciseDetail.description),
            textStyle: TextStyle(
                color: descriptionColor,
                fontSize: 17.sp,
                fontFamily: Constants.fontsFamily,
                fontWeight: FontWeight.w500,
                height: 1.41.h),
          ),
          ConstantWidget.getVerSpace(34.h),
        ],
      ),
    );
  }
}
