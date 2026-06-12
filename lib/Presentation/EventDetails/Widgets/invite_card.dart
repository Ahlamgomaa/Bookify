import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import 'event_helper_widgets.dart';

class InviteCard extends StatelessWidget {
  const InviteCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          buildAvatars(),
          const SizedBox(width: 10),
          const Text("+20 Going", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navyBlue)),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.navyBlue, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            onPressed: () {},
            child: const Text("Invite", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}