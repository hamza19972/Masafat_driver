import 'dart:convert';
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/mytripdata.dart';
import 'package:masafat_captain/view/screen/viewpasstrip.dart';

class ResponseData {
  String status;
  List<Trip> data;

  ResponseData({required this.status, required this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      status: json['status'],
      data: List<Trip>.from(json['data'].map((x) => Trip.fromJson(x))),
    );
  }
}

class Trip {
  String? tripID;
  String? driverID;
  String? routeID;
  String? departureDate;
  String? departureTime;
  String? gender;
  String? seats;
  String? status;

  Trip({
    required this.tripID,
    required this.driverID,
    required this.routeID,
    required this.departureDate,
    required this.departureTime,
    required this.gender,
    required this.seats,
    required this.status,
  });

  factory Trip.fromJson(Map<dynamic, dynamic> json) {
    return Trip(
      tripID: json['TripID']?.toString(),
      driverID: json['DriverID']?.toString(),
      routeID: json['RouteID']?.toString(),
      departureDate: json['DepartureDate']?.toString(),
      departureTime: json['DepartureTime']?.toString(),
      gender: json['gender']?.toString(),
      seats: json['seats']?.toString(),
      status: json['Status']?.toString(),
    );
  }
}

class MyTripV2 extends GetxController {
  List<Trip>? trips; // To store multiple trips
  MyTripData myTripData = MyTripData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest? statusRequest;
  @override
  void onInit() {
    getTrips();
    super.onInit();
  }

  getTrips() async {
    int? id = myServices.sharedPreferences.getInt("id");

    statusRequest = StatusRequest.loading;
    update(); // Notify listeners to show loading state

    try {
      var response = await myTripData.getDataV2(id!); // Hypothetical API call
      if (response is String) {
        // If response is a string, decode it
        response = json.decode(response);
      }
      var responseData =
          ResponseData.fromJson(response); // Parse into ResponseData

      if (responseData.status == 'success') {
        responseData.data
            .sort((a, b) => int.parse(b.tripID!).compareTo(int.parse(a.tripID!)));

        trips = responseData.data; // Update trips list
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure; // Handle non-success status
      }
      print("=============================== Controller $response");
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
    } finally {
      update(); // Notify listeners to update UI based on the new state
    }
  }

  gotopass(String tripid){
    Get.to(()=> ViewPassTripPage(),arguments: {"tripid":tripid});
  }
}
