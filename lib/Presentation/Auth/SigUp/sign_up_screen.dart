import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/constants.dart';
import '../../Home/home_screen.dart';
import '../Manager/auth_cubit.dart';
import '../Widgets/custom_text_field.dart';
import '../Widgets/social_login_button.dart';
import '../Widgets/shimmer_loading_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.navyBlue)
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('assets/images/splash_logo.png', height: 80)),
                  const SizedBox(height: 20),
                  const Text("Sign up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.navyBlue)),
                  const SizedBox(height: 25),

                  CustomTextField(
                    hint: "Full name",
                    icon: Icons.person_outline,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Enter Your Email",
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Enter Your password",
                    icon: Icons.lock_outline,
                    obscureText: true,
                    showEye: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Confirm password",
                    icon: Icons.lock_outline,
                    obscureText: true,
                    showEye: true,
                    controller: _confirmPasswordController,
                  ),

                  const SizedBox(height: 30),
                  ShimmerLoadingButton(
                    text: "Sign Up",
                    isLoading: isLoading,
                    onPressed: () {
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

                      context.read<AuthCubit>().signUp(name, email, password);
                    },
                  ),
                  const SizedBox(height: 15),
                  const Center(child: Text("OR", style: TextStyle(color: Colors.grey))),
                  const SizedBox(height: 15),
                  SocialLoginButton(
                    text: "Login with Google",
                    icon: Icons.g_mobiledata,
                    onPressed: () {},
                  ),

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
            );
          },
        ),
      ),
    );
  }
}