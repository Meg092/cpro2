import 'package:get/get.dart';

import 'cpro_land_logic.dart';

class CproLandBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      CproLandLogic(),
      permanent: true,
    );
  }
}
