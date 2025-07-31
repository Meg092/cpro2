import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CproMainLogic extends GetxController {
  int currentPage = 0;

  var showWeekDay = true;
  var showAPM = true;
  var autoLandscape = true;

  var hourTextColor = Colors.white.withOpacity(0.4);
  var minutesTextColor = Colors.white.withOpacity(0.4);
  var clockFamily = 0;

  List<Uint8List> bgPImages = [];
  List<Uint8List> bgLImages = [];

  Future<Uint8List> assetImageToUInt8List(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  void imageSelected(Orientation orientation) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
          imageQuality: 90, maxWidth: 1024, source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (orientation == Orientation.portrait) {
          bgPImages.replaceRange(currentPage, currentPage + 1, [imageBytes]);
          await prefs.setStringList(
              'bgPImages', bgPImages.map((e) => base64Encode(e)).toList());
        } else {
          bgLImages.replaceRange(currentPage, currentPage + 1, [imageBytes]);
          await prefs.setStringList(
              'bgLImages', bgLImages.map((e) => base64Encode(e)).toList());
        }
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showWeekDay = prefs.getBool('showWeekDay') ?? true;
    showAPM = prefs.getBool('showAPM') ?? true;
    autoLandscape = prefs.getBool('autoLandscape') ?? true;
    hourTextColor = (prefs.getString('hourTextColor') ?? '').toColor() ??
        Colors.white.withOpacity(0.4);
    minutesTextColor = (prefs.getString('minutesTextColor') ?? '').toColor() ??
        Colors.white.withOpacity(0.4);
    clockFamily = prefs.getInt('clockFamily') ?? 0;
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final autoLandscape = prefs.getBool('autoLandscape') ?? true;
    if (autoLandscape) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    bgPImages.clear();
    bgLImages.clear();
    for (int i = 0; i < 4; i++) {
      bgPImages.add(await assetImageToUInt8List('assets/bgp$i.webp'));
      bgLImages.add(await assetImageToUInt8List('assets/bgl$i.webp'));
    }
    final bgPImagesPres = prefs.getStringList('bgPImages');
    if (bgPImagesPres != null) {
      bgPImages = prefs.getStringList('bgPImages')!.map((e) {
        return Uint8List.fromList(base64Decode(e));
      }).toList();
    }
    final bgLImagesPres = prefs.getStringList('bgLImages');
    if (bgLImagesPres != null) {
      bgLImages = prefs.getStringList('bgLImages')!.map((e) {
        return Uint8List.fromList(base64Decode(e));
      }).toList();
    }
    await getData();
    update();
    super.onInit();
  }
}
