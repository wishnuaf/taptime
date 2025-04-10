import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController {
  final fromDate = Rxn<DateTime>();
  final toDate = Rxn<DateTime>();
  final reports = [].obs;

  void pickDate(BuildContext context, {required bool isFrom}) async {
    DateTime initial = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isFrom) {
        fromDate.value = picked;
      } else {
        toDate.value = picked;
      }
    }
  }

  Future<void> fetchReports() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      if (fromDate.value == null || toDate.value == null) return;

      DateTime start = DateTime(
        fromDate.value!.year,
        fromDate.value!.month,
        fromDate.value!.day,
      );
      DateTime end = DateTime(
        toDate.value!.year,
        toDate.value!.month,
        toDate.value!.day + 1,
      );

      final snapshot =
          await FirebaseFirestore.instance
              .collection('karyawan')
              .doc(user.uid)
              .collection('presences')
              .where('uid', isEqualTo: user.uid)
              .where(
                'timestamp',
                isGreaterThanOrEqualTo: Timestamp.fromDate(start),
              )
              .where('timestamp', isLessThan: Timestamp.fromDate(end))
              .orderBy('timestamp', descending: true)
              .get();

      reports.value = snapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data: $e');
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
