import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/mytrip_controller.dart';

class Mytrip extends StatelessWidget {
  const Mytrip({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyTripController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('51'.tr),
      ),
      body: GetBuilder<MyTripController>(
        builder: (controller) => ListView.builder(
          itemCount: controller.trips.length,
          itemBuilder: (context, index) {
            final trip = controller.trips[index];
            return Card(
              color: Colors.blue[50],
              elevation: 5, // Adds shadow under the card
              margin: const EdgeInsets.all(8), // Adds margin around the card
              child: InkWell(
                onTap: () {
                  controller.goToDetalis(trip
                      .tripId); // Assuming goToDetails method accepts tripId as a parameter
                },
                splashColor: Colors.green.withAlpha(30), // Splash color on tap
                child: Padding(
                  padding:
                      const EdgeInsets.all(16.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns content to the start of the column
                    children: [
                      Text(
                        '42'.tr + ': ${trip.tripId}',
                        style: const TextStyle(
                          fontSize: 20, // Increases font size
                          fontWeight: FontWeight.bold, // Makes text bold
                        ),
                      ),
                      const SizedBox(
                          height: 10), // Adds space between the lines
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Spreads row items across space
                        children: [
                          Text(
                            '52'.tr,
                            style: TextStyle(
                              fontSize: 16, // Font size for the trip route
                              color: Colors
                                  .grey[600], // Dim color for less emphasis
                            ),
                          ),
                          Text(
                            'JOD ${trip.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize:
                                  18, // Slightly larger font size for price
                              color: Colors.green[
                                  700], // Green color for price to stand out
                              fontWeight:
                                  FontWeight.bold, // Bold price for emphasis
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
