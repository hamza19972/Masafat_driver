import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/mytripv2_controller.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';

class TripsPage extends StatelessWidget {
  final MyTripV2 controller = Get.put(MyTripV2());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("63".tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.getTrips(), // Refresh the trips list
          ),
        ],
      ),
      body: GetBuilder<MyTripV2>(builder: (controller) {
        if (controller.statusRequest == StatusRequest.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.statusRequest == StatusRequest.success) {
          if (controller.trips?.isEmpty ?? true) {
            return Center(child: Text("100".tr));
          }
          return ListView.builder(
            itemCount: controller.trips?.length ?? 0,
            itemBuilder: (context, index) {
              Trip trip = controller.trips![index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text('${'42'.tr}${trip.tripID}'),
                  subtitle: Text('${'101'.tr}: ${trip.departureDate} ${'102'.tr} ${trip.departureTime}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Optionally, navigate to a detail view or perform another action
                    controller.gotopass(trip.tripID!);
                  },
                ),
              );
            },
          );
        } else {
          return Center(child: Text("103".tr, style: const TextStyle(fontSize: 18)));
        
    }}),
    );
  }
}
