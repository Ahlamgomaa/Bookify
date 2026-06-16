import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../../Data/Local/database_helper.dart';
import '../../../Data/Local/secure_storage_helper.dart';
import '../../../Data/Local/shared_prefs_helper.dart';
import '../../Home/home_screen.dart';
import '../SigUp/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  void _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter email and password')));
      return;
    }

    setState(() { _isLoading = true; });

    try {
      final user = await DatabaseHelper.instance.getUserByEmail(email);
      if (user == null) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found')));
        return;
      }

      final storedPassword = await SecureStorageHelper.getPassword(email);
      if (storedPassword != password) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect password')));
        return;
      }

      // Update remember_me flag
      int rememberMeValue = _rememberMe ? 1 : 0;
      await DatabaseHelper.instance.updateUser({
        'id': user['id'],
        'name': user['name'],
        'email': user['email'],
        'remember_me': rememberMeValue,
      });

      await SharedPrefsHelper.setLoggedIn(true, userId: user['id']);

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

  void _showRememberedAccountsDialog() async {
    final rememberedUsers = await DatabaseHelper.instance.getRememberedUsers();
    
    if (!mounted) return;
    if (rememberedUsers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No remembered accounts found')));
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
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
                    Navigator.pop(context); // close dialog
                    
                    // Proceed to login
                    setState(() { _isLoading = true; });
                    await SharedPrefsHelper.setLoggedIn(true, userId: user['id']);
                    if (mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    }
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

              _buildField("ahlam@email.com", Icons.email_outlined, controller: _emailController),
              const SizedBox(height: 16),
              _buildField("Enter Your password", Icons.lock_outline, obscure: true, showEye: true, controller: _passwordController),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity, height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.navyBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: _isLoading ? null : _signIn,
                  child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Sign In", style: TextStyle(color:Colors.white , fontSize: 16, fontWeight: FontWeight.bold)),
                ),
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
                    onTap: _showRememberedAccountsDialog,
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
      label: Text(text, style: const TextStyle(color:  AppColors.pumpkinOrange, fontWeight: FontWeight.w500)),
    );
  }
}