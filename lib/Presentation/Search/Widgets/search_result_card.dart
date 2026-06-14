import 'package:flutter/material.dart';

import '../../../Core/constants.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1st May - Sat - 2:00 PM",
                  style: TextStyle(
                    color: AppColors.pumpkinOrange,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "A virtual evening of\nsmooth jazz",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.navyBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
