import 'package:flutter/material.dart';
import '../Model/OnBoarding_Model.dart';
import 'Widgets/OnBoarding_Page.dart';

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
      description:
      "Find events happening around you and stay updated with the latest activities.",
    ),
    OnboardingModel(
      image: "assets/images/onboarding2.jpg",
      title: "We Have Modern Events Calendar Feature",
      description:
      "Track and organize your events easily with our modern calendar.",
    ),
    OnboardingModel(
      image: "assets/images/onboarding3.jpg",
      title: "Look Up More Events Nearby By Map",
      description:
      "Discover events around your location using interactive maps.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            model: pages[index],
            currentPage: currentPage,
            totalPages: pages.length,
            onNext: () {
              if (index < pages.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
              }
            },
          );
        },
      ),
    );
  }
}