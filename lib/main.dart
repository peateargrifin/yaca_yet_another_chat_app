import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yaca/api/fireapi.dart';
import 'package:yaca/pages/intro.dart';
import 'package:yaca/themes/light_mode.dart';
import 'package:yaca/themes/themepro.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //final fireapi notifservice = fireapi();
  //await notifservice.initnotif();
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeprovider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: intro(),
      theme: Provider.of<themeprovider>(context).themedata,
    );
  }
}
