import 'package:flutter/material.dart';
import 'package:flutter_women_workout_ui/util/color_category.dart';
import 'package:flutter_women_workout_ui/view/language/language_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../util/constants.dart';

class LanguageScreen extends GetView {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Language".tr,
            style: TextStyle(
                color: Colors.black,
                fontFamily: Constants.fontsFamily,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<LanguageProvider>(
          builder: (context, value, child) => Column(children: [
            _LangaugeListTile(
                title: "English",
                onPressed: () {
                  value.selectLanguage(Language.english);
                },
                selected: value.selectedLanguage == Language.english),
            _LangaugeListTile(
                title: "العربية",
                onPressed: () {
                  value.selectLanguage(Language.arabic);
                },
                selected: value.selectedLanguage == Language.arabic),
          ]),
        ));
  }
}

class _LangaugeListTile extends StatelessWidget {
  const _LangaugeListTile({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.selected,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(title),
      trailing: selected
          ? Icon(
              Icons.check_circle_rounded,
              color: accentColor,
            )
          : null,
    );
  }
}
