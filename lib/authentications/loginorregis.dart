import 'package:flutter/material.dart';
import 'package:yaca/pages/loginpg.dart';

import '../pages/registerpg.dart';

class loginorregi extends StatefulWidget {
  const loginorregi({super.key});

  @override
  State<loginorregi> createState() => _loginorregiState();
}

class _loginorregiState extends State<loginorregi> {
  bool showlogin = true;

  void toggle() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return authpage(ontp: toggle);
    } else {
      return RegisterPage(ontp: toggle);
    }
    // return const Placeholder();
  }
}
