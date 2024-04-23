import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/text_form_field.dart';
import '../authentication_controller.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Create an Account",
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "To get started now!",
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // Allow user to pick an image.
                  authenticationController.chooseImageFromGallery();
                },
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("images/profile_avatar.jpg"),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // User name textField
                      InputTextField(
                          controller: authenticationController.userName,
                          iconData: const Icon(Icons.person_outline),
                          fieldName: "Username"),
                      const SizedBox(height: 20),
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
                          isObscure: true),
                      const SizedBox(height: 20),
                      // Sign Up button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            // sign up user
                            if (authenticationController.profileImage != null &&
                                authenticationController
                                    .userName.text.isNotEmpty &&
                                authenticationController
                                    .email.text.isNotEmpty &&
                                authenticationController
                                    .password.text.isNotEmpty) {
                              authenticationController.createAccountForNewUser(
                                authenticationController.userName.text.trim(),
                                authenticationController.email.text.trim(),
                                authenticationController.password.text.trim(),
                                authenticationController.profileImage!,
                              );
                              debugPrint('button was clicked');
                            }
                          },
                          child: const Text(
                            "Sign Up",
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
                            "Already have an Account?",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SimpleCircularProgressBar(
                      //   progressColors: [
                      //     Colors.green,
                      //     Colors.blueAccent,
                      //     Colors.red,
                      //     Colors.amber,
                      //     Colors.purpleAccent,
                      //   ],
                      //   animationDuration: 3,
                      //   backColor: Colors.white38,
                      // ),
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
