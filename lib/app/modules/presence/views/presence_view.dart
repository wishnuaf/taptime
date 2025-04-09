import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/presence_controller.dart';

class PresenceView extends GetView<PresenceController> {
  const PresenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/fingerprint.png', height: 50),
            const SizedBox(height: 10),
            const Text(
              'TapTime',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF62D0FF), Color(0xFF007BFF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time, color: Colors.white),
                  const SizedBox(width: 8),
                  Obx(
                    () => Text(
                      controller.currentTime.value,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Pilih Lokasi Kerja'),
                value:
                    controller.selectedLocation.value.isEmpty
                        ? null
                        : controller.selectedLocation.value,
                items:
                    controller.locations
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                onChanged:
                    (val) => controller.selectedLocation.value = val ?? '',
              ),
            ),

            const SizedBox(height: 12),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Pilih Status'),
                value:
                    controller.selectedStatus.value.isEmpty
                        ? null
                        : controller.selectedStatus.value,
                items:
                    controller.statuses
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                onChanged: (val) => controller.selectedStatus.value = val ?? '',
              ),
            ),

            const SizedBox(height: 12),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text('Map Placeholder'),
            ),

            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                minimumSize: const Size.fromHeight(45),
              ),
              child: const Text('Refresh Map'),
            ),

            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: controller.submitAttendance,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BFF),
                minimumSize: const Size.fromHeight(45),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.fingerprint), label: "Tap"),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: "Report",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
