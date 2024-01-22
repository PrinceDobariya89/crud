import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_rnw/constant/routes.dart';
import 'package:test_rnw/firebase_options.dart';
import 'package:test_rnw/helper/db_helper.dart';
import 'package:test_rnw/screens/home_screen.dart';
import 'package:test_rnw/screens/liked_recipe_screen.dart';
import 'package:test_rnw/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.db();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC43939)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      getPages: [
        GetPage(name: splashScreen, page: () => const SplashScreen()),
        GetPage(name: homeScreen, page: () => const HomeScreen()),
        GetPage(name: likedScreen, page: () => const LikedRecipeScreen())
      ],
    );
  }
}
