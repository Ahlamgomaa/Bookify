import 'package:flutter/material.dart';
import '../../../Core/constants.dart';

class EventTabs extends StatelessWidget {
  final bool isUpcoming;
  final Function(bool) onTabChanged;

  const EventTabs({super.key, required this.isUpcoming, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          _buildTab("UpComing", isUpcoming, () => onTabChanged(true)),
          _buildTab("Past Events", !isUpcoming, () => onTabChanged(false)),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? AppColors.navyBlue : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}