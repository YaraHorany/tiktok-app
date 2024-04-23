import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_app/authentication/screens/login_screen.dart';
import 'user.dart' as user_model;

class AuthenticationController extends GetxController {
  late Rx<File?> _pickedFile;
  File? get profileImage => _pickedFile.value;

  // TextField Controllers to get data from TextFields
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void chooseImageFromGallery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "You have successfully selected your profile image.",
      );
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void captureImageWithCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "You have successfully captured your profile image with phone camera.",
      );
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void createAccountForNewUser(String userName, String userEmail,
      String userPassword, File imageFile) async {
    try {
      // Create user in the firebase authentication.
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

      // Save the user profile image to firebase storage.
      String imageDownloadUrl = await uploadImageToStorage(imageFile);

      // Save user data to the firestore database.
      user_model.User user = user_model.User(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        id: credential.user!.uid,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());

      Get.snackbar(
          "Account Created", "Congratulations, your account has been created.");
    } catch (error) {
      print("error: $error");
      Get.snackbar("Account Creation Unsuccessful",
          "Error Occurred while creating the account.");
      Get.to(() => const LoginScreen());
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    // The imageFile is saved to the profile images folder by the user unique Id
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrlOfUploadedImage = await taskSnapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedImage;
  }
}
