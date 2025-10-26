import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaca/authentications/auth_service.dart';
import 'package:yaca/pages/registerpg.dart';

class authpage extends StatelessWidget {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final void Function()? ontp;

  authpage({super.key, required this.ontp});

  Future<void> login(BuildContext context) async {
    final authservic = authservice();

    showDialog(
      context: context,

      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _userIdController.text,
        password: _passwordController.text,
        //Navigator.pop(context);
      );

      // Success - pop the loading dialog

      Navigator.pop(context);

      //print('Login successful!'); // Debug print

      // Navigate to next screen or show success
    } on FirebaseAuthException catch (e) {
      // Pop the loading dialog first
      Navigator.pop(context);

      print('Error code: ${e.code}'); // Debug print to see actual error
      print('Error message: ${e.message}'); // Debug print

      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Invalid email or password.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  //   const authpage({Key? key}) : super(key: key);
  //
  //   @override
  //   State<authpage> createState() => _authpageState();
  // }

  //class _authpageState extends State<authpage> {

  // final void Function()? ontp;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.chat_bubble_rounded,
                    size: 50,
                    color: Color(0xFFE8D4B7),
                  ),
                ),
                const SizedBox(height: 30),

                // Welcome Text
                Text(
                  'Welcome Back',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    //fontFamily: 'Poppins',
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue.',
                  style: GoogleFonts.bubblerOne(
                    fontSize: 30,
                    color: colorScheme.primary,
                    //fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 50),

                // User ID TextField
                Container(
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
                    controller: _userIdController,
                    style: GoogleFonts.nunito(
                      color: colorScheme.primary,
                      // fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      labelStyle: GoogleFonts.nunito(
                        color: colorScheme.primary.withOpacity(0.7),
                        // fontFamily: 'Nunito',
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF934790),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password TextField
                Container(
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
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: GoogleFonts.nunito(
                      color: colorScheme.primary,
                      //fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.nunito(
                        color: colorScheme.primary.withOpacity(0.7),
                        //fontFamily: 'Nunito',
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFF934790),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF934790),
                        ),
                        onPressed: () {
                          _obscurePassword = !_obscurePassword;
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password action
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.nunito(
                        color: colorScheme.secondary,

                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => login(context),
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
                      'Login',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Poppins',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Sign Up Text
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.nunito(
                            color: colorScheme.primary,
                            //fontFamily: 'Nunito',
                            fontSize: 17,
                          ),
                        ),
                        TextButton(
                          onPressed: ontp, //() {
                          // Navigate to sign up
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => RegisterPage()));
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.nunito(
                              color: colorScheme.secondary,
                              //fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),

                    //SizedBox(height: 30,)
                  ],
                ),

                //const SizedBox(height: 30),

                // Or Continue With
                Row(
                  children: [
                    //SizedBox(width: 30,),
                    Expanded(
                      child: Divider(thickness: 0.9, color: Colors.grey[400]),
                    ),
                    Text(
                      '    Or continue with.    ',
                      style: GoogleFonts.nunito(),
                    ),

                    Expanded(
                      child: Divider(thickness: 0.9, color: Colors.grey[400]),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80, top: 15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => authservice().signgoogle(),

                            child: Image.asset(
                              'assets/images/google.png',

                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 90),

                    InkWell(
                      onTap: () {},

                      child: Image.asset(
                        'assets/images/applee.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
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
}
