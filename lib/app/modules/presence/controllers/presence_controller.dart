import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresenceController extends GetxController {
  var selectedLocation = ''.obs;
  var selectedStatus = ''.obs;
  var currentTime = ''.obs;

  List<String> locations = ['WFA', 'WFO'];
  List<String> statuses = ['IN', 'OUT'];

  @override
  void onInit() {
    super.onInit();
    updateTime();
  }

  void updateTime() {
    currentTime.value = DateFormat.Hms(
      'id_ID',
    ).format(DateTime.now().toUtc().add(const Duration(hours: 7))); // WIB
    Future.delayed(const Duration(seconds: 1), updateTime);
  }

  void submitAttendance() async {
    if (selectedLocation.value.isEmpty || selectedStatus.value.isEmpty) {
      Get.snackbar("Gagal", "Pilih lokasi dan status terlebih dahulu");
    } else {
      try {
        await FirebaseFirestore.instance.collection("presensi").add({
          "location": selectedLocation.value,
          "status": selectedStatus.value,
          "time": currentTime.value,
          "timestamp": FieldValue.serverTimestamp(),
        });
        Get.snackbar(
          "Berhasil",
          "Absen ${selectedStatus.value} di ${selectedLocation.value} pada ${currentTime.value}",
        );
      } catch (e) {
        Get.snackbar("Error", "Gagal menyimpan ke Firestore");
      }
    }
  }
}
