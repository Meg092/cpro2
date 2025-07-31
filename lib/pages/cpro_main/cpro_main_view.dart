import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rotation_clock/pages/cpro_main/second_item.dart';
import 'package:rotation_clock/pages/cpro_main/third_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'cpro_main_logic.dart';
import 'first_item.dart';
import 'fourth_item.dart';

class CproMainView extends StatefulWidget {
  const CproMainView({Key? key}) : super(key: key);

  @override
  State<CproMainView> createState() => _ClockMainPageState();
}

class _ClockMainPageState extends State<CproMainView> {
  CproMainLogic controller = Get.find();
  final _pageController = PageController();

  void _onPageChanged(int index) {
    controller.currentPage = index;
    controller.update();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void vhuiabjbhsd() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/cpro_mode');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    vhuiabjbhsd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CproMainLogic>(builder: (_) {
        return controller.bgPImages.isEmpty
            ? const SizedBox()
            : OrientationBuilder(builder: (_, orientation) {
                final items = [
                  FirstItem(
                    orientation == Orientation.portrait
                        ? controller.bgPImages[0]
                        : controller.bgLImages[0],
                    hourTextColor: controller.hourTextColor,
                    minutesTextColor: controller.minutesTextColor,
                    fontFamily: controller.clockFamily,
                    orientation: orientation,
                    showWeekDay: controller.showWeekDay,
                    showAPM: controller.showAPM,
                  ),
                  SecondItem(
                    orientation == Orientation.portrait
                        ? controller.bgPImages[1]
                        : controller.bgLImages[1],
                    hourTextColor: controller.hourTextColor,
                    minutesTextColor: controller.minutesTextColor,
                    fontFamily: controller.clockFamily,
                    orientation: orientation,
                    showWeekDay: controller.showWeekDay,
                    showAPM: controller.showAPM,
                  ),
                  ThirdItem(
                    orientation == Orientation.portrait
                        ? controller.bgPImages[2]
                        : controller.bgLImages[2],
                    hourTextColor: controller.hourTextColor,
                    minutesTextColor: controller.minutesTextColor,
                    fontFamily: controller.clockFamily,
                    orientation: orientation,
                    showWeekDay: controller.showWeekDay,
                    showAPM: controller.showAPM,
                  ),
                  FourthItem(
                    orientation == Orientation.portrait
                        ? controller.bgPImages[3]
                        : controller.bgLImages[3],
                    hourTextColor: controller.hourTextColor,
                    minutesTextColor: controller.minutesTextColor,
                    fontFamily: controller.clockFamily,
                    orientation: orientation,
                    showWeekDay: controller.showWeekDay,
                    showAPM: controller.showAPM,
                  )
                ];
                return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: <Widget>[
                      const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      PageView(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        children: items,
                      ),
                      orientation == Orientation.portrait
                          ? Positioned(
                              top: 60,
                              left: 15,
                              right: 15,
                              child: <Widget>[
                                Image.asset(
                                  'assets/icon0.webp',
                                  fit: BoxFit.cover,
                                ).gestures(onTap: () {
                                  controller.imageSelected(orientation);
                                }),
                                Image.asset(
                                  'assets/icon1.webp',
                                  fit: BoxFit.cover,
                                ).gestures(onTap: () {
                                  Get.toNamed('/cpro_setting')
                                      ?.then((_) async {
                                    controller.getData();
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final autoLandscape =
                                        prefs.getBool('autoLandscape') ?? true;
                                    if (autoLandscape) {
                                      await SystemChrome
                                          .setPreferredOrientations([
                                        DeviceOrientation.landscapeLeft,
                                        DeviceOrientation.landscapeRight,
                                      ]);
                                    } else {
                                      await SystemChrome
                                          .setPreferredOrientations([
                                        DeviceOrientation.portraitUp,
                                        DeviceOrientation.portraitDown,
                                        DeviceOrientation.landscapeLeft,
                                        DeviceOrientation.landscapeRight,
                                      ]);
                                    }
                                  });
                                }),
                              ].toRow(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween))
                          : Positioned(
                              top: 20,
                              right: 55,
                              child: <Widget>[
                                Image.asset(
                                  'assets/icon0.webp',
                                  fit: BoxFit.cover,
                                ).gestures(onTap: () {
                                  controller.imageSelected(orientation);
                                }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/icon1.webp',
                                  fit: BoxFit.cover,
                                ).gestures(onTap: () {
                                  Get.toNamed('/cpro_setting')
                                      ?.then((_) async {
                                    controller.getData();
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final autoLandscape =
                                        prefs.getBool('autoLandscape') ?? true;
                                    if (autoLandscape) {
                                      await SystemChrome
                                          .setPreferredOrientations([
                                        DeviceOrientation.landscapeLeft,
                                        DeviceOrientation.landscapeRight,
                                      ]);
                                    } else {
                                      await SystemChrome
                                          .setPreferredOrientations([
                                        DeviceOrientation.portraitUp,
                                        DeviceOrientation.portraitDown,
                                        DeviceOrientation.landscapeLeft,
                                        DeviceOrientation.landscapeRight,
                                      ]);
                                    }
                                  });
                                }),
                              ].toColumn()),
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                items.length,
                                (index) => _buildDot(index),
                              )),
                        ),
                      ),
                    ].toStack());
              });
      }),
    );
  }

  Widget _buildDot(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == controller.currentPage
              ? Colors.white
              : Colors.white.withOpacity(0.21),
        ),
      ),
    );
  }
}
