import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../../Data/Models/OnBoarding_Model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.model,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
    required this.onFinish,
  });

  final OnboardingModel model;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(model.image, fit: BoxFit.cover),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 280,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  model.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: onSkip,
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: AppColors.pumpkinOrange),
                      ),
                    ),

                    Row(
                      children: List.generate(
                        totalPages,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == index ? 10 : 8,
                          height: currentPage == index ? 10 : 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? AppColors.pumpkinOrange
                                : AppColors.pumpkinOrange.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: currentPage == totalPages - 1
                          ? onFinish
                          : onNext,
                      child: Text(
                        currentPage == totalPages - 1 ? "Finish" : "Next",
                        style: const TextStyle(color: AppColors.pumpkinOrange),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}