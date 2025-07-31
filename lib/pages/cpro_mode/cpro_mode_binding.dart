import 'package:get/get.dart';

import 'cpro_mode_logic.dart';

class CproModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CproModeLogic());
  }
}
