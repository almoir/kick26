import 'package:flutter/material.dart';
import 'package:kick24/src/common/colors.dart';
import 'package:kick24/src/presentation/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: ConstColors.black,
        appBarTheme: AppBarTheme(backgroundColor: ConstColors.black),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      home: SplashScreen(),
    );
  }
}
