import 'package:flutter/material.dart';
import '../../../../Core/constants.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 28, color: AppColors.pumpkinOrange),
      label: Text(
        text,
        style: const TextStyle(
          color: AppColors.pumpkinOrange,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
