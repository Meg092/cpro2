import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cpro_land_logic.dart';

class CproLandView extends GetView<CproLandLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.olson.value
              ? const CircularProgressIndicator(color: Colors.white38)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.etxs();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
