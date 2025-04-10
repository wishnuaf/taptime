import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taptime/app/modules/loginscreen/views/loginscreen_view.dart';
import 'package:taptime/app/modules/navigation/views/main_view.dart';

import '../controllers/authgate_controller.dart';

class AuthgateView extends GetView<AuthgateController> {
  const AuthgateView({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          return MainView(); // user login → masuk ke halaman utama dengan BottomNav
        } else {
          return LoginscreenView(); // belum login → masuk ke login page
        }
      },
    );
  }
}
