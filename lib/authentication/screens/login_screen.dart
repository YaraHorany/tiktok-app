import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/authentication/screens/signup_screen.dart';
import '../../widgets/text_form_field.dart';
import '../authentication_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset("images/tiktok.png"),
              Text(
                "Log in to TikTok",
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Glad to see you!",
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100),
              Form(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Email textField
                      InputTextField(
                          controller: authenticationController.email,
                          iconData: const Icon(Icons.email_outlined),
                          fieldName: "Email Address"),
                      const SizedBox(height: 20),
                      // Password textField
                      InputTextField(
                        controller: authenticationController.password,
                        iconData: const Icon(Icons.lock_outline),
                        fieldName: "Password",
                        isObscure: true,
                      ),
                      const SizedBox(height: 20),
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            debugPrint('button was clicked');
                            if (authenticationController
                                    .email.text.isNotEmpty &&
                                authenticationController
                                    .password.text.isNotEmpty) {
                              authenticationController.loginUserNow(
                                authenticationController.email.text.trim(),
                                authenticationController.password.text.trim(),
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      // Don't have an account? Sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an Account?",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => SignUpScreen());
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SimpleCircularProgressBar(
                        progressColors: [
                          Colors.green,
                          Colors.blueAccent,
                          Colors.red,
                          Colors.amber,
                          Colors.purpleAccent,
                        ],
                        animationDuration: 3,
                        backColor: Colors.white38,
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
}
