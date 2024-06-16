import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/utils/app_constans.dart';
import 'package:imtihon3_clon/views/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void changeMode(void a) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    AppConstans.themeCheck = !AppConstans.themeCheck;
    sharedPreferences.setBool("them", AppConstans.themeCheck);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    AppConstans.themeCheck = sharedPreferences.getBool("them")?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppConstans.themeCheck ? ThemeData.dark() : ThemeData.light(),
          home: SplashScreen(
            themChanged: changeMode,
          ),
        ));
  }
}
