import 'package:get/get.dart';

import 'cpro_main_logic.dart';

class CproMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CproMainLogic());
  }
}
