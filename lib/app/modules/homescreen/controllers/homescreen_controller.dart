import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomescreenController extends GetxController {
  //TODO: Implement HomescreenController

  final username = 'Charlie Herwitz'.obs;
  final profileUrl = 'https://i.pravatar.cc/150?img=3'.obs;
  final attendanceData = {
    'Tepat Waktu': {'value': '30', 'unit': 'Hari', 'icon': Icons.check_box, 'color': Colors.green},
    'Tidak Masuk': {'value': '1', 'unit': 'Hari', 'icon': Icons.cancel, 'color': Colors.red},
    'Terlambat': {'value': '23', 'unit': 'Menit', 'icon': Icons.timer_off, 'color': Colors.red},
    'Lebih Awal': {'value': '30', 'unit': 'Menit', 'icon': Icons.check_circle, 'color': Colors.green},
    'Saldo Cuti': {'value': '10', 'unit': 'Hari', 'icon': Icons.remove_circle, 'color': Colors.red},
  }.obs;

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
