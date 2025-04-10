import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/presence_controller.dart';

class PresenceView extends GetView<PresenceController> {
  const PresenceView({super.key});

  @override
  Widget build(BuildContext context) {
    final PresenceController controller = Get.put(PresenceController());
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF62D0FF), Color(0xFF007BFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, color: Colors.white),
                    const SizedBox(width: 8),
                    Obx(
                      () => Text(
                        controller.currentTime.value,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Dropdown lokasi kerja
              DropdownButtonFormField<String>(
                value:
                    controller.selectedLocation.value.isNotEmpty
                        ? controller.selectedLocation.value
                        : null,
                items:
                    controller.locations
                        .map(
                          (loc) =>
                              DropdownMenuItem(value: loc, child: Text(loc)),
                        )
                        .toList(),
                decoration: const InputDecoration(
                  labelText: 'Pilih Lokasi Kerja',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.selectedLocation.value = value ?? '';
                },
              ),
              const SizedBox(height: 12),

              // Dropdown status
              DropdownButtonFormField<String>(
                value:
                    controller.selectedStatus.value.isNotEmpty
                        ? controller.selectedStatus.value
                        : null,
                items:
                    controller.statuses
                        .map(
                          (status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ),
                        )
                        .toList(),
                decoration: const InputDecoration(
                  labelText: 'Pilih Status',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.selectedStatus.value = value ?? '';
                },
              ),
              const SizedBox(height: 12),

              // Dummy Map
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text("Map Placeholder")),
              ),
              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(45),
                ),
                child: const Text("Refresh Map"),
              ),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: controller.submitPresence,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(45),
                ),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
