import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptime/app/modules/navigation/views/main_view.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void register() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Semua field wajib diisi');
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password tidak cocok');
      return;
    }

    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        // Simpan data pengguna ke Firestore
        await firestore.collection('karyawan').doc(uid).set({
          'username': username,
          'email': email,
          'phone': phone,
          'uid': uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Get.snackbar('Sukses', 'Pendaftaran berhasil');
      // Redirect ke login / home
      Get.offAll(() => MainView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Gagal', e.message ?? 'Terjadi kesalahan');
    } finally {
      isLoading.value = false;
    }
  }
}
