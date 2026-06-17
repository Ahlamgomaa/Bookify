import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/constants.dart';
import '../../../Data/repository/local_repository.dart';
import '../../Home/home_screen.dart';
import '../SigUp/sign_up_screen.dart';
import '../Manager/auth_cubit.dart';
import '../Widgets/custom_text_field.dart';
import '../Widgets/social_login_button.dart';
import '../Widgets/shimmer_loading_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  final _localRepo = LocalRepository();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showRememberedAccountsDialog() async {
    final rememberedUsers = await _localRepo.getRememberedUsers();
    
    if (!mounted) return;
    if (rememberedUsers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No remembered accounts found')));
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Select Account'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: rememberedUsers.length,
              itemBuilder: (context, index) {
                final user = rememberedUsers[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user['name'] ?? ''),
                  subtitle: Text(user['email'] ?? ''),
                  onTap: () async {
                    Navigator.pop(dialogContext);
                    context.read<AuthCubit>().loginWithSavedAccount(user['id']);
                  },
                );
              },
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
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
                  children: [
                    const SizedBox(height: 60),
                    Image.asset('assets/images/splash_logo.png', height: 100),
                    const SizedBox(height: 40),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sign in", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.navyBlue))),
                    const SizedBox(height: 18),

                    CustomTextField(
                      hint: "Enter Your email",
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

                    const SizedBox(height: 30),
                    ShimmerLoadingButton(
                      text: "Sign In",
                      isLoading: isLoading,
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text;

                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter email and password')));
                          return;
                        }

                        context.read<AuthCubit>().signIn(email, password, _rememberMe);
                      },
                    ),
                    const SizedBox(height: 15),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          activeColor: AppColors.pumpkinOrange,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          child: const Text(
                            "Remember me",
                            style: TextStyle(
                              color: AppColors.navyBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () => _showRememberedAccountsDialog(),
                          child: const Text(
                            "Saved Accounts",
                            style: TextStyle(
                              color: AppColors.pumpkinOrange,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 15),
                    const Text("OR", style: TextStyle(color: AppColors.navyBlue)),
                    const SizedBox(height: 15),

                    SocialLoginButton(
                      text: "Login with Google",
                      icon: Icons.g_mobiledata,
                      onPressed: () {},
                    ),

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
              );
            },
          ),
        ),
      ),
    );
  }
}