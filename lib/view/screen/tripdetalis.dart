import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/tripdetalis_controller.dart';
import 'package:masafat_captain/view/screen/home/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

class TripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TripDetalisController controller = Get.put(TripDetalisController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Here you can set your desired color for the back button and other AppBar icons
        ),
        title: Text(
          '55'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Enhanced color for AppBar
      ),
      body: GetBuilder<TripDetalisController>(
        builder: (controller) {
          if (controller.trips.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Colors.green,));
          }
          return ListView.separated(
            itemCount: controller.trips.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final trip = controller.trips[index];
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trip details implementation
                    Text(
                      trip.userName,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text("0${trip.userPhone}",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 5),
                     Row(
                      children: [
                        const Icon(
                          Icons.price_check_sharp,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text("66".tr+" ${trip.price}",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Trip.openMap(trip.pickupLocation);
                              },
                              child: Text("56".tr,
                                  style: const TextStyle(fontSize: 16))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.flag, color: Colors.blue, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Trip.openMap(trip.dropoffLocation);
                                },
                                child: Text(
                                    "57".tr,
                                    style: const TextStyle(fontSize: 16)))),
                      ],
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      buttonHeight: 52,
                      buttonMinWidth: 90,
                      children: [
                        const SizedBox(
                          width: 90,
                        ),TextButton.icon(
                          icon: const Icon(Icons.call, color: Colors.green),
                          label: Text('60'.tr,
                              style: const TextStyle(color: Colors.green)),
                          onPressed: () =>
                              launchUrl(Uri.parse("tel:0${trip.userPhone}")),
                        ),
                  ],
                ),
                   
                      ],
              ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Get.dialog(AlertDialog(
            title: Text('21'.tr),
            content: Text("58".tr),
            actions: [
              TextButton(
                child: Text('29'.tr),
                onPressed: () => Get.back(),
              ),
              TextButton(
                child: Text('59'.tr),
                onPressed: () {
                  controller.cancelTrip(); // Assuming this method exists in your controller
                  Get.offAll(()=>HomePage()); // Close the dialog
                },
              ),
            ],
          ));
        },
        child: const Icon(
          Icons.cancel_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
