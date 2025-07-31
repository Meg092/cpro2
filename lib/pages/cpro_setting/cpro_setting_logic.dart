import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class CproSettingLogic extends GetxController {
  var showWeekDay = true.obs;
  var showAPM = true.obs;
  var autoLandscape = true.obs;
  var appVersion = '1.0.0'.obs;
  var clockFamily = 0.obs;
  var hourTextColor = Colors.white.withOpacity(0.4).obs;
  var minutesTextColor = Colors.white.withOpacity(0.4).obs;

  void showFontFamily(BuildContext context) async {
    BottomPicker(
      pickerTitle: const Text(''),
      items: List.generate(clockFamilyList.length, (index) {
        return Text(
          clockFamilyList[index],
          style: TextStyle(fontFamily: clockFamilyList[index]),
        );
      }),
      onSubmit: (index) async {
        clockFamily.value = index;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('clockFamily', index);
      },
    ).show(context);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showWeekDay.value = prefs.getBool('showWeekDay') ?? true;
    showAPM.value = prefs.getBool('showAPM') ?? true;
    autoLandscape.value = prefs.getBool('autoLandscape') ?? true;
    clockFamily.value = prefs.getInt('clockFamily') ?? 0;
    hourTextColor.value = (prefs.getString('hourTextColor') ?? '').toColor() ??
        Colors.white.withOpacity(0.4);
    minutesTextColor.value = (prefs.getString('minutesTextColor') ?? '').toColor() ??
        Colors.white.withOpacity(0.4);
    var info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
    super.onInit();
  }
}
