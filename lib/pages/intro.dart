import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:yaca/authentications/loginorregis.dart';
import 'package:yaca/themes/light_mode.dart';

import '../authentications/gate.dart';
import 'loginpg.dart';

class intro extends StatelessWidget {
  const intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF9A036A),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chat_bubble_rounded,
                  size: 60,
                  color: Color(0xFFE8D4B7),
                ),
              ),
              const SizedBox(height: 40),

              // App Title
              Text(
                'Y A C A.',
                style: GoogleFonts.bubblerOne(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF934790),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Yet Another Chat App',
                style: GoogleFonts.bubblerOne(
                  fontSize: 18,
                  color: const Color(0xFF934790),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 60),

              // Main Button
              ElevatedButton(
                //onPressed: gate(),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => gate()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0066),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFFFF0066).withOpacity(0.5),
                ),
                child: Text(
                  "Let's connect.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage in main.dart:
// void main() {
//   runApp(const MaterialApp(
//     home: IntroPage(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
