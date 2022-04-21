import 'package:desafio/screen/create_plan_screen.dart';
import 'package:desafio/screen/options_screen.dart';
import 'package:desafio/screen/result_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:desafio/screen/home_screen.dart';
import 'package:desafio/screen/simulation_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: !kIsWeb
        ? null
        : const FirebaseOptions(
            apiKey: 'AIzaSyB0aSnI6tZFZnTAyqfM6PpkRA52_Kgruls',
            authDomain: 'desafio-wattio-jackson.firebaseapp.com',
            projectId: 'desafio-wattio-jackson',
            storageBucket: 'desafio-wattio-jackson.appspot.com',
            messagingSenderId: '100309355048',
            appId: '1:100309355048:web:7c3cb683e2a9f8d248431d',
            measurementId: 'G-G979FELX24',
          ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WATTio',
      initialRoute: HomeScreen.nameRoute,
      routes: {
        ...HomeScreen.route,
        ...SimulationScreen.route,
        ...OptionsScreen.route,
        ...ResultScreen.route,
        ...CreatePlanScreen.route,
      },
    );
  }
}
