import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SplashView'), centerTitle: true),
      body: const Center(
        child: Text('SplashView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
