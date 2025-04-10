import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taptime/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget buildTextField(
    String hint,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF62D0FF), Color(0xFF007BFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/images/taptime-logo.png', width: 100),
              const SizedBox(height: 37),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Silahkan daftar ke aplikasi',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              buildTextField(
                'Masukkan Username',
                controller.usernameController,
                Icons.person,
              ),
              buildTextField(
                'Masukkan Email',
                controller.emailController,
                Icons.email,
              ),
              buildTextField(
                'Masukkan Nomor Telepon',
                controller.phoneController,
                Icons.phone,
              ),
              buildTextField(
                'Masukkan Kata Sandi',
                controller.passwordController,
                Icons.lock,
                isPassword: true,
              ),
              buildTextField(
                'Masukkan Ulang Kata Sandi',
                controller.confirmPasswordController,
                Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 12),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child:
                      controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.blue)
                          : const Text('Daftar'),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Get.offNamed(Routes.LOGINSCREEN),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  minimumSize: const Size.fromHeight(45),
                ),
                child: const Text('Sudah Punya Akun ? Masuk Disini'),
              ),
              const SizedBox(height: 150),
              const Text(
                'powered by PPKD',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
