import 'package:flutter/material.dart';
import 'package:yaca/pages/loginpg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../authentications/auth_service.dart';

class RegisterPage extends StatelessWidget {
  // const RegisterPage({Key? key}) : super(key: key);

  //   @override
  //   State<RegisterPage> createState() => _RegisterPageState();
  // }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;

  //bool _obscureConfirmPassword = true;

  final void Function()? ontp;

  RegisterPage({super.key, required this.ontp});

  // void register() {
  //   if (_passwordController.text == _confirmPasswordController.text &&
  //       _passwordController.text.length > 6 &&
  //       _confirmPasswordController != null) {
  //     final authserv = authservice();
  //     authserv.signupwithemail(_emailController.text, _passwordController.text);
  //   }
  // }

  // registerpg.dart

  // Change the function signature to accept BuildContext
  Future<void> register(BuildContext context) async {
    // --- 1. Show a loading indicator ---
    showDialog(
      context: context,
      barrierDismissible: false, // User can't dismiss it
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // --- 2. Validate passwords ---
    if (_passwordController.text != _confirmPasswordController.text) {
      // Pop the loading circle
      Navigator.pop(context);
      // Show an error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match!")));
      return; // Stop the function
    }

    // --- 3. Try to sign up ---
    try {
      final authserv = authservice();
      await authserv.signupwithemail(
        _emailController.text,
        _passwordController.text,
      );

      // Pop the loading circle on success
      // Check if the widget is still mounted before using context
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on Exception catch (e) {
      // Pop the loading circle on error
      Navigator.pop(context);
      // Show the specific error to the user
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () {
            // Navigate back
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Logo
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person_add_rounded,
                    size: 45,
                    color: Color(0xFFE8D4B7),
                  ),
                ),
                const SizedBox(height: 25),

                // Create Account Text
                Text(
                  'Create Account',
                  style: GoogleFonts.lato(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    //fontFamily: 'Poppins',
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Join YACA today.',
                  style: GoogleFonts.bubblerOne(
                    fontSize: 30,
                    color: colorScheme.primary,
                    //fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 40),

                // Email TextField
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  colorScheme: colorScheme,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Password TextField
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock_outline,
                  colorScheme: colorScheme,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: colorScheme.primary,
                    ),
                    onPressed: () {
                      _obscurePassword = !_obscurePassword;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password TextField
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  icon: Icons.lock_outline,
                  colorScheme: colorScheme,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: colorScheme.primary,
                    ),
                    onPressed: () {
                      _obscurePassword = !_obscurePassword;
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => register(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFFFF0066).withOpacity(0.4),
                    ),
                    child: Text(
                      'Register',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Poppins',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Register action
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: colorScheme.secondary,
                //       foregroundColor: Colors.white,
                //       padding: const EdgeInsets.symmetric(vertical: 18),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       elevation: 8,
                //       shadowColor: colorScheme.secondary.withOpacity(0.4),
                //     ),
                //     child: Text(
                //       'Register',
                //       style: GoogleFonts.lato(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //         //fontFamily: 'Poppins',
                //         letterSpacing: 1,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 25),

                // Already have account Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontFamily: 'Nunito',
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: ontp,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: colorScheme.secondary,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ColorScheme colorScheme,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: colorScheme.primary,
          fontFamily: 'Nunito',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: colorScheme.primary.withOpacity(0.7),
            fontFamily: 'Nunito',
          ),
          prefixIcon: Icon(icon, color: colorScheme.primary),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

// Example usage in main.dart:
// void main() {
//   runApp(MaterialApp(
//     theme: AppTheme.lightTheme,
//     darkTheme: AppTheme.darkTheme,
//     themeMode: ThemeMode.system,
//     home: RegisterPage(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
