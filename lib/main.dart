import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'authentication/authentication_controller.dart';
import 'authentication/screens/login_screen.dart';
import 'package:get/get.dart';

// https://www.youtube.com/watch?v=lPwzBVMcj1s&list=PLxefhmF0pcPkvw_suc_FUCy8oCSPWer0r&index=1&ab_channel=MuhammadAli%27sCodingCafe

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then(
    (value) {
      Get.put(AuthenticationController());
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TikTok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: LoginScreen(),
    );
  }
}
