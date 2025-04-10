import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => GestureDetector(
                        onTap: () => controller.pickDate(context, isFrom: true),
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Dari Tanggal',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: controller.formatDate(
                                controller.fromDate.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                      () => GestureDetector(
                        onTap:
                            () => controller.pickDate(context, isFrom: false),
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Sampai Tanggal',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: controller.formatDate(
                                controller.toDate.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.fetchReports,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Lihat Laporan"),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF62D0FF), Color(0xFF007BFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Tanggal", style: TextStyle(color: Colors.white)),
                    Text("Waktu", style: TextStyle(color: Colors.white)),
                    Text("Lokasi", style: TextStyle(color: Colors.white)),
                    Text("Status", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.reports.length,
                    itemBuilder: (context, index) {
                      final item = controller.reports[index];
                      final timestamp = item['timestamp'] as Timestamp?;
                      final date = timestamp?.toDate();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat('dd-MM-yyyy').format(date!)),
                              Text(item['time'] ?? '-'),
                              Text(item['location'] ?? '-'),
                              Text(
                                item['status'] ?? '-',
                                style: TextStyle(
                                  color:
                                      (item['status'] == 'In')
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
