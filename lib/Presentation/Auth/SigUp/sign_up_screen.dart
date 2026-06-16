import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../../Data/repository/local_repository.dart';
import '../../Home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _localRepo = LocalRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() { _isLoading = true; });

    try {
      final existingUser = await _localRepo.getUserByEmail(email);
      if (existingUser != null) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email already exists')));
        return;
      }

      int userId = await _localRepo.insertUser({
        'name': name,
        'email': email,
        'remember_me': 1,
      });

      await _localRepo.savePassword(email, password);
      await _localRepo.setLoggedIn(true, userId: userId);

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.navyBlue)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/splash_logo.png', height: 80)),
            const SizedBox(height: 20),
            const Text("Sign up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.navyBlue)),
            const SizedBox(height: 25),

            _buildField("Full name", Icons.person_outline, controller: _nameController),
            const SizedBox(height: 16),
            _buildField("abc@email.com", Icons.email_outlined, controller: _emailController),
            const SizedBox(height: 16),
            _buildField("Your password", Icons.lock_outline, obscure: true, showEye: true, controller: _passwordController),
            const SizedBox(height: 16),
            _buildField("Confirm password", Icons.lock_outline, obscure: true, showEye: true, controller: _confirmPasswordController),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navyBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 15),
            const Center(child: Text("OR", style: TextStyle(color: Colors.grey))),
            const SizedBox(height: 15),
            _socialButton("Login with Google", Icons.g_mobiledata),

            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: AppColors.navyBlue, fontSize: 14),
                      ),
                      TextSpan(
                        text: "Sign in",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, {bool obscure = false, bool showEye = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
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
      label: Text(text, style: const TextStyle(color: AppColors.pumpkinOrange, fontWeight: FontWeight.w500)),
    );
  }
}