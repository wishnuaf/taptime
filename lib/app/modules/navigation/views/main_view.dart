import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptime/app/modules/homescreen/views/homescreen_view.dart';
import 'package:taptime/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:taptime/app/modules/presence/views/presence_view.dart';
import 'package:taptime/app/modules/report/views/report_view.dart';
import 'package:taptime/app/routes/app_pages.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> pages = const [
    HomescreenView(),
    PresenceView(),
    ReportView(),
    // SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Image.asset('assets/images/taptime-logo.png', width: 50),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF62D0FF), Color(0xFF007BFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed(Routes.LOGINSCREEN);
              },
            ),
          ],
        ),
        body: IndexedStack(
          index: navController.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          onTap: navController.changeIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.fingerprint),
              label: 'Tap',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              label: 'Report',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
