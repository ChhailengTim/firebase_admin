import 'package:firebase_admin/screen/admin_screen.dart';
import 'package:firebase_admin/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final displayName = '';
  //AuthController.instance...
  //final AuthController instance = Get.find();
  //email, password, name...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //out user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      debugPrint("login page");
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => AdminScreen(
            email: user.email,
          ));
    }
  }

  void singIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      // Get.snackbar(
      //   "About user",
      //   "User message",
      //   backgroundColor: Colors.redAccent,
      //   snackPosition: SnackPosition.BOTTOM,
      //   titleText: const Text(
      //     "Account Sing in failed",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   messageText: Text(
      //     e.toString(),
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // );
    }
  }

  void singup() async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      // Get.snackbar(
      //   "About user",
      //   "User message",
      //   backgroundColor: Colors.redAccent,
      //   snackPosition: SnackPosition.BOTTOM,
      //   titleText: const Text(
      //     "Account creation failed",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   messageText: Text(
      //     e.toString(),
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // );
    }
  }

  void singout() async {
    await auth.signOut();
  }
}
