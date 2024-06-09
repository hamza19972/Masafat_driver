import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/afteraddcontroller.dart';

class TripFormPage extends StatelessWidget {
  final int routeID;

  TripFormPage({Key? key, required this.routeID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pass the routeID to the controller
    final AfterAddController controller =
        Get.put(AfterAddController(routeID: routeID));

    return Scaffold(
      appBar: AppBar(title:  Text('79'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("${"80".tr}:$routeID", style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              // Departure Date
              Obx(() => ListTile(
                    title: Text(
                        '${"81".tr}: ${controller.selectedDate.value?.toString().substring(0, 10) ?? "82".tr}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => controller.selectDate(context),
                  )),
              // Departure Time
              Obx(() => ListTile(
                    title: Text(
                        '${"83".tr}: ${controller.selectedTime.value?.format(context) ?? "84".tr}'),
                    trailing: const Icon(Icons.watch_later),
                    onTap: () => controller.selectTime(context),
                  )),
              // Gender selection
              Obx(() => DropdownButtonFormField<int>(
                    value: controller.gender.value,
                    onChanged: (newValue) {
                      controller.gender.value = newValue!;
                    },
                    items: [
                       DropdownMenuItem<int>(
                        value: 1,
                        child: Text("85".tr),
                      ),
                       DropdownMenuItem<int>(
                        value: 0,
                        child: Text("86".tr),
                      ),
                    ],
                    decoration:  InputDecoration(
                      labelText: '87'.tr,
                    ),
                  )),
              const SizedBox(height: 20),
              // Submit button
              Obx(() => ElevatedButton(
                    onPressed: (controller.selectedDate.value != null &&
                            controller.selectedTime.value != null)
                        ? () {
                            controller.postData();
                            
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green, // Background color
                    ),
                    child:  Text('59'.tr),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
