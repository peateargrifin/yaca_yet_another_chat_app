import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yaca/authentications/loginorregis.dart';

import '../pages/chathome.dart';

class gate extends StatelessWidget {
  const gate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: chathome());
          } else {
            return loginorregi();
          }
        },
      ),
    );
  }
}
