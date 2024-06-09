import 'dart:convert';
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/mytripdata.dart';
import 'package:masafat_captain/view/screen/home/homepage.dart';

class PassengerResponse {
  String status;
  List<Passenger> data;

  PassengerResponse({required this.status, required this.data});

  factory PassengerResponse.fromJson(Map<String, dynamic> json) {
    return PassengerResponse(
      status: json['status'],
      data: json['data'] != null
          ? List<Passenger>.from(json['data'].map((x) => Passenger.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class Passenger {
  String id;
  String tripId;
  String passengerId;
  String name;
  String userPhone;
  String driverId;
  String pickupLocation;
  String dropoffLocation;
  String seatsBooked;
  String price;

  Passenger({
    required this.id,
    required this.tripId,
    required this.passengerId,
    required this.name,
    required this.userPhone,
    required this.driverId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.seatsBooked,
    required this.price,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      id: json['id']?.toString() ?? '',
      tripId: json['trip_id']?.toString() ?? '',
      passengerId: json['passenger_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      userPhone: json['user_phone']?.toString() ?? '',
      driverId: json['driverId']?.toString() ?? '',
      pickupLocation: json['pickup_location']?.toString() ?? '',
      dropoffLocation: json['dropoff_location']?.toString() ?? '',
      seatsBooked: json['seats_booked']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trip_id': tripId,
      'passenger_id': passengerId,
      'name': name,
      'user_phone': userPhone,
      'driverId': driverId,
      'pickup_location': pickupLocation,
      'dropoff_location': dropoffLocation,
      'seats_booked': seatsBooked,
      'price': price,
    };
  }
}

class ViewPassTrip extends GetxController {
  String? tripid;
  List<Passenger>? passenger;
  MyTripData myTripData = MyTripData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest? statusRequest;

  @override
  void onInit() {
    tripid = Get.arguments['tripid'];
    getTrips();
    super.onInit();
  }

  getTrips() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await myTripData.getpasstrip(tripid!);
      if (response is String) {
        response = json.decode(response);
      }

      var responseData = PassengerResponse.fromJson(response);

      if (responseData.status == 'success') {
        passenger = responseData.data;
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
    } finally {
      update();
    }
  }

  canceltrip() async {
    try {
      var response = await myTripData.canceleTrip(tripid!);

      var responseData = PassengerResponse.fromJson(response);

      if (responseData.status == 'success') {
        Get.snackbar("69".tr, "76".tr);
        Get.offAll(() => HomePage());
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
    } finally {
      update();
    }
  }

  fulltrip() async {
    try {
      var response = await myTripData.fulltrip(tripid!);

      var responseData = PassengerResponse.fromJson(response);

      if (responseData.status == 'success') {
        Get.snackbar("69".tr, "77".tr);
        Get.offAll(() => HomePage());

        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
    } finally {
      update();
    }
  }
}
