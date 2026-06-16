import 'dart:async';
import 'package:flutter/material.dart';

import '../OnBoarding/OnBoarding_Screen.dart';
import '../Home/home_screen.dart';
import '../../Data/repository/local_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _localRepo = LocalRepository();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      if (!mounted) return;

      final isLogged = await _localRepo.isLoggedIn();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isLogged ? const HomeScreen() : const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: Center(
        child: Image.asset(
          'assets/images/splash_logo.png',
          width: 250,
        ),
      ),
    );
  }
}