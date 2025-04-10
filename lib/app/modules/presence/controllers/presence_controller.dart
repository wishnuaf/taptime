import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taptime/app/modules/homescreen/controllers/homescreen_controller.dart';

class PresenceController extends GetxController {
  final currentTime = ''.obs;
  final selectedLocation = ''.obs;
  final selectedStatus = ''.obs;

  final locations = ['WFA', 'WFO'];
  final statuses = ['In', 'Out'];

  final homescreenController = Get.find<HomescreenController>();

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _startClock();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now().toUtc().add(
        const Duration(hours: 7),
      ); // WIB = UTC+7
      currentTime.value = DateFormat.Hms().format(now);
    });
  }

  void submitPresence() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User belum login!');
        return;
      }

      // (opsional) Ambil nama user dari Firestore jika tidak disimpan di displayName
      String? name = user.displayName;
      if (name == null || name.isEmpty) {
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();
        name = userDoc.data()?['name'] ?? 'Tidak diketahui';
      }

      await FirebaseFirestore.instance
          .collection('karyawan')
          .doc(user.uid)
          .collection('presences')
          .add({
            'uid': user.uid,
            'username': name,
            'timestamp': FieldValue.serverTimestamp(),
            'time': currentTime.value,
            'location': selectedLocation.value,
            'status': selectedStatus.value,
          });

      await homescreenController.fetchAttendanceSummary(user.uid);

      Get.snackbar('Sukses', 'Data absensi berhasil dikirim!');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengirim data: $e');
    }
  }
}
