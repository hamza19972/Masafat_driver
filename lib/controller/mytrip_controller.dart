import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/mytripdata.dart';
import 'package:masafat_captain/view/screen/tripdetalis.dart';

class TripResponse {
  String status;
  List<Trip> data;

  TripResponse({required this.status, required this.data});

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      status: json['status'],
      data: List<Trip>.from(json['data'].map((x) => Trip.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Trip {
  int tripId;
  List<dynamic> matchedRideIds;
  String pickupLocation;
  String dropoffLocation;
  String tripDate;
  String tripTime;
  int seats;
  int status;
  int driverId;
  String pickupName;
  String dropoffName;
  double price;

  Trip({
    required this.tripId,
    required this.matchedRideIds,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.tripDate,
    required this.tripTime,
    required this.seats,
    required this.status,
    required this.driverId,
    required this.pickupName,
    required this.dropoffName,
    required this.price,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      tripId: int.parse(json['trip_id']),
      matchedRideIds: json['matched_ride_ids'].split(',').map((id) => int.parse(id)).toList(),
      pickupLocation: json['pickup_location'],
      dropoffLocation: json['dropoff_location'],
      tripDate: json['trip_date'],
      tripTime: json['trip_time'],
      seats: int.parse(json['seats']),
      status: int.parse(json['status']),
      driverId: int.parse(json['driver_id']),
      pickupName: json['pickup_name'],
      dropoffName: json['dropoff_name'],
      price: double.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': tripId.toString(),
      'matched_ride_ids': matchedRideIds.join(","),
      'pickup_location': pickupLocation,
      'dropoff_location': dropoffLocation,
      'trip_date': tripDate,
      'trip_time': tripTime,
      'seats': seats.toString(),
      'status': status.toString(),
      'driver_id': driverId.toString(),
      'pickup_name': pickupName,
      'dropoff_name': dropoffName,
      'price': price.toString(),
    };
  }
}


class MyTripController extends GetxController {
  int? driverId;
  List<Trip> trips =<Trip>[].obs;
  StatusRequest? statusRequest;
  MyTripData myTripData = MyTripData(Get.find());
  MyServices myServices = Get.find();
  @override
  void onInit() {
    driverId = myServices.sharedPreferences.getInt("id");
    getMyTrip();

    super.onInit();
  }

  getMyTrip() async {
    try {
      var response = await myTripData.getData(driverId!);
      print("=============================== Controller $response ");

      if (response['status'] == "success") {
      List<dynamic> tripList = response['data'];
      // Convert JSON to Trip objects and sort them in decreasing order by tripId
      var tripsTemp = tripList.map((tripJson) => Trip.fromJson(tripJson)).toList();
      // Sorting in decreasing order
      tripsTemp.sort((a, b) => b.tripId.compareTo(a.tripId));

      trips.clear(); // Clear the existing list before adding sorted trips
      trips.addAll(tripsTemp); // Add the sorted list to trips
      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;
    }
  } catch (e) {
    print('Error fetching data: $e');
    statusRequest = StatusRequest.failure;
  }
  update(); // Notify listeners to
  }

  goToDetalis(int tripid){
    
    Get.to(()=>TripPage(),arguments: {"tripid":tripid});
  }
}
