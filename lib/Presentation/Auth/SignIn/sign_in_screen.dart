import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../EventDetails/event_details_screen.dart';
import '../SigUp/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset('assets/images/splash_logo.png', height: 100),
              const SizedBox(height: 40),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Sign in", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.navyBlue))),
              const SizedBox(height: 18),

              _buildField("ahlam@email.com", Icons.email_outlined),
              const SizedBox(height: 16),
              _buildField("Enter Your password", Icons.lock_outline, obscure: true, showEye: true),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity, height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.navyBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventDetailsScreen()),
                    );
                  },
                  child: const Text("Sign In", style: TextStyle(color:Colors.white , fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 15),
              const Text("OR", style: TextStyle(color: AppColors.navyBlue)),
              const SizedBox(height: 25),

              _socialButton("Login with Google", Icons.g_mobiledata),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: AppColors.navyBlue, fontSize: 14),
                      ),
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(
                          color: AppColors.pumpkinOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, {bool obscure = false, bool showEye = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.navyBlue),
        suffixIcon: showEye ? const Icon(Icons.visibility_off, color: Colors.grey) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {},
      icon: Icon(icon, size: 28, color: AppColors.pumpkinOrange),
      label: Text(text, style: const TextStyle(color:  AppColors.pumpkinOrange, fontWeight: FontWeight.w500)),
    );
  }
}