import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotation_clock/pages/cpro_land/cpro_land_binding.dart';
import 'package:rotation_clock/pages/cpro_land/cpro_land_view.dart';
import 'package:rotation_clock/pages/cpro_main/cpro_main_binding.dart';
import 'package:rotation_clock/pages/cpro_main/cpro_main_view.dart';
import 'package:rotation_clock/pages/cpro_main/item_slider.dart';
import 'package:rotation_clock/pages/cpro_mode/cpro_mode_binding.dart';
import 'package:rotation_clock/pages/cpro_mode/cpro_mode_view.dart';
import 'package:rotation_clock/pages/cpro_setting/cpro_setting_binding.dart';
import 'package:rotation_clock/pages/cpro_setting/cpro_setting_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Color primaryColor = Colors.black;
Color bgColor = const Color(0xff1d1d1d);

List<String> clockFamilyList = [
  'Bangers',
  'Google_Sans_Code',
  'Gravitas_One',
  'Monoton',
  'Permanent_Marker',
  'Rock_Salt',
  'Sacramento',
  'Silkscreen'
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final showWeekDay = prefs.getBool('showWeekDay');
  if (showWeekDay == null) {
    await prefs.setBool('showWeekDay', true);
    await prefs.setBool('showAPM', true);
    await prefs.setBool('autoLandscape', true);
    await prefs.setInt('clockFamily', 0);
    await prefs.setString('hourTextColor', Colors.white.withOpacity(0.4).toHexString());
    await prefs.setString('minutesTextColor', Colors.white.withOpacity(0.4).toHexString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages:CPro,
      initialRoute: '/cpro_tab',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> CPro = [
  GetPage(name: '/cpro_tab', page: () => CproLandView(), binding: CproLandBinding()),
  GetPage(name: '/cpro_main', page: () => const CproMainView(), binding: CproMainBinding()),
  GetPage(name: '/cpro_slider', page: () => ItemSlider()),
  GetPage(name: '/cpro_setting', page: () => CproSettingView(), binding: CproSettingBinding()),
  GetPage(name: '/cpro_mode', page: () => CproModeView(), binding: CproModeBinding()),
];