import 'package:get/get.dart';

import 'cpro_setting_logic.dart';

class CproSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CproSettingLogic());
  }
}
