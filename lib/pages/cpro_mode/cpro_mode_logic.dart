
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CproModeLogic extends GetxController {

  void cjhbahoiqds() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Fluttertoast.showToast(msg: 'Unable to connect to the server, please check your network settings');
    } else {
      Fluttertoast.showToast(msg: 'You are connected to the internet');
      Get.back();
    }
  }

}
