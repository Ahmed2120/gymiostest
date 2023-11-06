import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/data/dummy_data.dart';
import 'package:get/get.dart';

class GuideIntroController extends GetxController {
  var pageController;
  var position = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageController.disclose;
  }
}

class LoginController extends GetxController {
  var emailController;
  var passwordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   emailController.disclose;
  //   passwordController.disclose;
  // }
}

class ForgotController extends GetxController {
  late TextEditingController emailController;
  RxString code = "+20".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
  }
}

class ResetController extends GetxController {
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}

class ChangePasswordController extends GetxController {
  var oldPasswordController;
  var newPasswordController;
  var confirmPasswordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }
}

class IntroController extends GetxController {
  var sliderPosition = 0;
  RxInt genderPosition = 0.obs;
  RxInt age = 20.obs;
  RxInt cm = 120.obs;
  RxInt ft = 25.obs;
  RxInt inch = 25.obs;

  RxInt kg = 25.obs;
  RxInt lbs = 25.obs;
  RxInt selectWeek = 0.obs;

  onWeekChange(RxInt position) {
    selectWeek.value = position.value;
    update();
  }

  onChange(RxInt position) {
    genderPosition.value = position.value;
    update();
  }

  ageChange(RxInt value) {
    age.value = value.value;
    update();
  }

  cmChange(int value) {
    cm.value = value;
    update();
  }

  ftChange(int value, int value1) {
    ft.value = value;
    inch.value = value1;
  }

  kgChange(int value) {
    kg.value = value;
    update();
  }

  lbsChange(int value) {
    lbs.value = value;
    update();
  }
}

class SignUpController extends GetxController {
  late TextEditingController phoneNumberController;
  late TextEditingController fullNameController;
  late TextEditingController textPasswordController;
  late TextEditingController emailController;
  RxBool check = false.obs;
  RxString image = "image_albania.jpg".obs;
  RxString code = "+20".obs;

  getImage(String value, String value1) {
    image.value = value;
    code.value = value1;
    update();
  }

  onCheck() {
    check.value = check.value == true ? false : true;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneNumberController = TextEditingController();
    fullNameController = TextEditingController();
    textPasswordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    phoneNumberController.dispose();
    fullNameController.dispose();
    textPasswordController.dispose();
    emailController.dispose();
  }
}

class HomeController extends GetxController {
  RxInt index = 0.obs;

  RxInt progressIndex = 0.obs;

  onProgressChange(RxInt value) {
    progressIndex.value = value.value;
    update();
  }

  onChange(RxInt value) {
    index.value = value.value;
    update();
  }
}

class ActivityController extends GetxController {
  Rx<DateTime> selectDate = DateTime.now().obs;
  RxInt select = 0.obs;
  RxInt item = 5.obs;

  itemChange(RxInt value, RxInt value1) {
    select.value = value.value;
    item.value = value1.value;
    update();
  }

  onChange(Rx<DateTime> date) {
    selectDate.value = date.value;
    update();
  }
}

class SettingController extends GetxController {
  RxBool screen = false.obs;
  RxInt dropDownValue = 10.obs;
  var caloriesController;
  var nameController;
  var emailController;
  var phoneNumberController;
  RxString calories = "100".obs;
  RxDouble tts_speed = 0.5.obs;
  RxBool ttsSpeak = true.obs;
  RxDouble volume = 1.0.obs;
  RxBool sound = true.obs;
  RxInt unitIndex = 0.obs;
  RxBool isKgUnit = true.obs;

  changeKgUnit() {
    isKgUnit.value = unitIndex.value == 0 ? true : false;
    update();
  }

  changeUnitIndex(int index) {
    unitIndex.value = index;
    update();
  }

  changeSound() {
    if (sound.value == true) {
      sound.value = false;
      changeVolume(0.0);
    } else {
      sound.value = true;
      changeVolume(1.0);
    }
    update();
  }

  fullVolume() {
    sound.value = true;
    update();
  }

  changeVolume(double value) {
    volume.value = value;
    if (value == 0.0) {
      sound.value = false;
    } else {
      sound.value = true;
    }
    update();
  }

  changeTtsSpeak() {
    ttsSpeak.value = ttsSpeak.value ? false : true;
    update();
  }

  changeTtsSpeed(double value) {
    tts_speed.value = value;

    update();
  }

  caloriesChange() {
    calories.value = caloriesController.text;
    update();
  }

  dropdownChange(int value) {
    dropDownValue.value = value;
    update();
  }

  screenChange(RxBool value) {
    screen.value = value.value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    caloriesController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}

class SelectWorkoutController extends GetxController {
  RxList<String> exerciseIdList = <String>[].obs;

  RxString categoryId = "1".obs;

  RxList<String> idList = <String>[].obs;

  onAddValue(String value) {
    if (!exerciseIdList.contains(value)) {
      exerciseIdList.add(value);

      update();
    }

    print("0nAdd----${exerciseIdList.length}");
  }

  onChangeIdList(var value) {
    exerciseIdList = value;
    update();
  }

  onRemoveValue(String value) {
    exerciseIdList.remove(value);
    idList.remove(value);
    update();
    print("onRemove----${exerciseIdList.length}");
  }

  onNotify() {
    update();
  }

  onOldIdList(List<String> value) {
    idList.value = value;
    update();
  }

  onChange(RxString value) {
    categoryId.value = value.value;
    update();
  }

  // onMakeList(int value) {
  //   duration = List<int>.generate(value, (index) => 10);
  //   update();
  // }

  addDuration(int index, String key, int data) {
    DummyData.setDuration(key, (data + 1));
    // duration[index] = duration[index] + 1;
    update();
  }

  minusDuration(int index, String key, int data) {
    if ((data - 1) >= 10) {
      DummyData.setDuration(key, (data - 1));
    }

    // duration[index] = duration[index] - 1;
    update();
  }
}
