import 'package:flutter/material.dart';
import 'package:kick26/src/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    initApp();
  }

  void initApp() {
    Future.delayed(const Duration(seconds: 5)).then((value) async {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/animations/splashscreen_kick26.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
