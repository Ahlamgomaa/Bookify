import 'package:flutter/material.dart';
import '../../Model/OnBoarding_Model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.model,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  final OnboardingModel model;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            model.image,
            fit: BoxFit.cover,
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 280,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF2C3E50),
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
                      onPressed: () {},
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Color(0xFFD35400),
                        ),
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
                                ? const Color(0xFFD35400)
                                : const Color(0xFFD35400).withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: onNext,
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Color(0xFFD35400),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}