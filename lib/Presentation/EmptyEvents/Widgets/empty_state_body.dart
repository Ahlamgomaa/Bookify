import 'package:flutter/material.dart';
import '../../../Core/constants.dart';

class EmptyStateBody extends StatelessWidget {
  final bool isUpcoming;
  const EmptyStateBody({super.key, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.calendar_month, size: 100, color: AppColors.navyBlue),
        ),
        const SizedBox(height: 20),
        Text(
          isUpcoming ? "No Upcoming Event" : "No Past Event",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navyBlue),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}