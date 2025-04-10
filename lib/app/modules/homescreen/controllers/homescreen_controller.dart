import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomescreenController extends GetxController {
  final username = ''.obs;
  final profileUrl = ''.obs;

  final attendanceData =
      {
        'WFA': {
          'value': '',
          'unit': 'Hari',
          'icon': Icons.person,
          'color': Colors.blueGrey,
        },
        'WFO': {
          'value': '',
          'unit': 'Hari',
          'icon': Icons.laptop,
          'color': Colors.blueGrey,
        },
      }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchAttendanceSummary(String uid) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('karyawan')
              .doc(uid)
              .collection('presences')
              .where(
                'status',
                isEqualTo: 'In',
              ) // Hanya ambil yang status-nya 'In'
              .get();

      int wfaCount = 0;
      int wfoCount = 0;

      for (var doc in snapshot.docs) {
        final location = doc.data()['location'];
        if (location == 'WFA') wfaCount++;
        if (location == 'WFO') wfoCount++;
      }

      // Update nilai ke dalam attendanceData
      attendanceData['WFA']?['value'] = wfaCount.toString();
      attendanceData['WFO']?['value'] = wfoCount.toString();
      attendanceData.refresh();
    } catch (e) {
      print('Error saat hitung WFA/WFO: $e');
    }
  }

  void fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc =
          await FirebaseFirestore.instance
              .collection('karyawan')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        username.value = data['username'] ?? 'Tanpa Nama';
        profileUrl.value = data['profileUrl'] ?? '';
      }

      // Setelah ambil user, hitung kehadiran
      await fetchAttendanceSummary(user.uid);
    } catch (e) {
      // print('Error: $e');
    }
  }
}
