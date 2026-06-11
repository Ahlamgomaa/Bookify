import 'package:flutter/material.dart';
import '../../Data/Models/OnBoarding_Model.dart';
import 'Widgets/OnBoarding_Page.dart';
import '../Auth/SignIn/sign_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: "assets/images/onboarding1.jpg",
      title: "Explore Upcoming and Nearby Events",
      description: "Find events happening around you and stay updated.",
    ),
    OnboardingModel(
      image: "assets/images/onboarding2.jpg",
      title: "Modern Events Calendar",
      description: "Track and organize your events easily.",
    ),
    OnboardingModel(
      image: "assets/images/onboarding3.jpg",
      title: "Find Events on Map",
      description: "Discover events around your location.",
    ),
  ];

  void goToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            model: pages[index],
            currentPage: currentPage,
            totalPages: pages.length,

            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },

            onSkip: goToSignIn,

            onFinish: goToSignIn,
          );
        },
      ),
    );
  }
}