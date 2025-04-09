import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomescreenController extends GetxController {
  final username = ''.obs;
  final profileUrl = ''.obs;

  final attendanceData =
      {
        'Tepat Waktu': {
          'value': '30',
          'unit': 'Hari',
          'icon': Icons.calendar_month,
          'color': Colors.green,
        },
        'Tidak Masuk': {
          'value': '1',
          'unit': 'Hari',
          'icon': Icons.cancel,
          'color': Colors.red,
        },
        'Terlambat': {
          'value': '23',
          'unit': 'Menit',
          'icon': Icons.timer_off,
          'color': Colors.red,
        },
        'Saldo Cuti': {
          'value': '10',
          'unit': 'Hari',
          'icon': Icons.remove_circle,
          'color': Colors.red,
        },
      }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      final userDoc =
          await FirebaseFirestore.instance
              .collection('karyawan')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        username.value = data['username'] ?? 'Tanpa Nama';
        profileUrl.value = data['profileUrl'] ?? '';
      } else {}
    } catch (e) {}
  }
}
