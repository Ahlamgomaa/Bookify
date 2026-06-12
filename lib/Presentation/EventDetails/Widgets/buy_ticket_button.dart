import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../EmptyEvents/empty_events_screen.dart';

class BuyTicketButton extends StatelessWidget {
  const BuyTicketButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.navyBlue, minimumSize: const Size(double.infinity, 50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmptyEventsScreen()),
            );
          },
          child: const Text("BUY TICKET \$120", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}