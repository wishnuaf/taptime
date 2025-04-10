import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taptime/app/modules/navigation/views/main_view.dart';

class LoginscreenController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final rememberMe = false.obs;

  void login() async {
    isLoading.value = true;
    try {
      final email = usernameController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        Fluttertoast.showToast(
          msg: "Username dan password tidak boleh kosong",
          backgroundColor: Colors.white,
          textColor: Colors.red,
        );
        isLoading.value = false;
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: "Login sukses",
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
      );
      Get.offAll(() => MainView());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }
}
