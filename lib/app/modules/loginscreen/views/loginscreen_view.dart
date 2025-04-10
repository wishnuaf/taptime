import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptime/app/modules/loginscreen/controllers/loginscreen_controller.dart';
import 'package:taptime/app/routes/app_pages.dart';

class LoginscreenView extends GetView<LoginscreenController> {
  const LoginscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF62D0FF), Color(0xFF007BFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/images/taptime-logo.png', width: 143),
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Masuk',
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
                  'Silahkan masuk ke aplikasi',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              // Row(
              //   children: [
              //     Obx(
              //       () => Checkbox(
              //         value: controller.rememberMe.value,
              //         onChanged:
              //             (value) =>
              //                 controller.rememberMe.value = value ?? false,
              //         checkColor: Colors.blue,
              //         activeColor: Colors.white,
              //       ),
              //     ),
              //     const Text(
              //       'Ingat saya',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     const Spacer(),
              //     TextButton(
              //       onPressed: () {},
              //       child: const Text(
              //         'Lupa sandi?',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 12),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child:
                      controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.blue)
                          : const Text('Masuk'),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  // TODO: Navigate to Register
                  Get.toNamed(Routes.REGISTER);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  minimumSize: const Size.fromHeight(45),
                ),
                child: const Text('Daftar'),
              ),
              const SizedBox(height: 260),
              const Text(
                'powered by PPKD',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
