import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masafat_captain/controller/viewpasstrip_controller.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';

class ViewPassTripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ViewPassTrip controller = Get.put(ViewPassTrip());

    return Scaffold(
      
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          '55'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: GetBuilder<ViewPassTrip>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          } else if (controller.statusRequest == StatusRequest.failure) {
            return  Center(
              child: Text(
                '104'.tr,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (controller.statusRequest == StatusRequest.success) {
            if (controller.passenger != null && controller.passenger!.isNotEmpty) {
              return ListView.separated(
                itemCount: controller.passenger!.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final passenger = controller.passenger![index];
                  final pickupCoordinates = extractCoordinatesFromString(passenger.pickupLocation);
                  final dropoffCoordinates = extractCoordinatesFromString(passenger.dropoffLocation);

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
                        
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              passenger.name,
                              style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.event_seat,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${'92'.tr}: ${passenger.seatsBooked}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_money,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${'66'.tr}: \$${passenger.price}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.red, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextButton(
                                onPressed: () => openMap(pickupCoordinates[0], pickupCoordinates[1]),
                                child:  Text(
                                  '18'.tr,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
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
                                onPressed: () => openMap(dropoffCoordinates[0], dropoffCoordinates[1]),
                                child:  Text(
                                  '17'.tr,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          buttonHeight: 52,
                          buttonMinWidth: 90,
                          children: [
                            const SizedBox(width: 90),
                            TextButton.icon(
                              icon: const Icon(Icons.call, color: Colors.green),
                              label:  Text(
                                '60'.tr,
                                style: TextStyle(color: Colors.green),
                              ),
                              onPressed: () => launchUrl(Uri.parse("tel:0${passenger.userPhone}")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return  Center(
                child: Text(
                  '105'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
          }
          return Container();
        },
      ),
      floatingActionButton: SpeedDial(animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.yellow,
        children: [
          SpeedDialChild(
            child: Icon(Icons.cancel),
            label: '106'.tr,
            backgroundColor: Colors.red,
            onTap: () => controller.canceltrip(),
          ),
          SpeedDialChild(
            child: Icon(Icons.done),
            label: '107'.tr,
            backgroundColor: Colors.green,
            onTap: () => controller.fulltrip(),
          ),
          
    ]));
  }

  List<double> extractCoordinatesFromString(String location) {
    final regExp = RegExp(r'POINT\(([^ ]+) ([^ )]+)\)', caseSensitive: false);
    final match = regExp.firstMatch(location);
    if (match != null) {
      try {
        final lat = double.parse(match.group(1)!);
        final lon = double.parse(match.group(2)!);
        return [lat, lon];
      } catch (e) {
        print('Error parsing coordinates: $e');
        return [0.0, 0.0];
      }
    }
    print('No match found for location: $location');
    return [0.0, 0.0];
  }

  static Future<void> openMap(double lat, double lng) async {
    final googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
