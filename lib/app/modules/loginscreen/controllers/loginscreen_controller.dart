import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptime/app/modules/homescreen/views/homescreen_view.dart';

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
        Get.snackbar("Error", "Username dan password tidak boleh kosong");
        isLoading.value = false;
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar("Berhasil", "Login sukses");
      // Arahkan ke halaman utama
      Get.offAll(() => HomescreenView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Gagal", e.message ?? "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }
  //TODO: Implement LoginscreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
