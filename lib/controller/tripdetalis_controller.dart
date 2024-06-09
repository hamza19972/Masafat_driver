import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/tripdetalisdata.dart';
import 'package:url_launcher/url_launcher.dart';

class TripResponse {
  String status;
  List<Trip> data;

  TripResponse({required this.status, required this.data});

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      status: json['status'],
      data: (json['data'] as List).map((item) => Trip.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((v) => v.toJson()).toList(),
    };
  }
}

class Trip {
  int tripId;
  String userName;
  String userPhone;
  String pickupLocation;
  String dropoffLocation;
  String date;
  String time;
  String status;
  int driverId;
  double price;

  Trip({
    required this.tripId,
    required this.userName,
    required this.userPhone,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.date,
    required this.time,
    required this.status,
    required this.driverId,
    required this.price,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      tripId: int.parse(json['trip_id']),
      userName: json['user_name'],
      userPhone: json['user_phone'],
      pickupLocation: json['pickup_location'],
      dropoffLocation: json['dropoff_location'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      driverId: int.parse(json['driver_id']),
      price: double.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': tripId.toString(),
      'user_name': userName,
      'user_phone': userPhone,
      'pickup_location': pickupLocation,
      'dropoff_location': dropoffLocation,
      'date': date,
      'time': time,
      'status': status,
      'driver_id': driverId.toString(),
      'price': price.toString(),
    };
  }



  // Helper method to open Google Maps
  static Future<void> openMap(String location) async {
    // Extract latitude and longitude from location string
    final locationPattern = RegExp(r'POINT\(([^)]+)\)');
    final match = locationPattern.firstMatch(location);
    if (match != null) {
      final String latLngStr = match.group(1)!;
      final latLng = latLngStr.split(' ');
      final lat = double.parse(latLng[0]);
      final lng = double.parse(latLng[1]);

      final googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl));
      } else {
        throw 'Could not open the map.';
      }
    }
  }
}


class TripDetalisController extends GetxController {
  int? tripid;
  int? driverid;
    var trips = <Trip>[].obs;

  TripDetalisData tripDetalisData = TripDetalisData(Get.find());
    StatusRequest statusRequest = StatusRequest.none;
      MyServices myServices = Get.find();



  @override
  void onInit() {
    tripid = Get.arguments['tripid'];
    fetchTrips();
    super.onInit();
  }
void fetchTrips() async {
  statusRequest = StatusRequest.loading;
  try {
    var response = await tripDetalisData.getData(tripid!);
    if (response['status'] == 'success') {
      List<dynamic> tripList = response['data'];
      var tripsTemp = tripList.map((tripJson) => Trip.fromJson(tripJson)).toList();
      trips.clear();
      trips.addAll(tripsTemp);
      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.offlinefailure;
    }
  } catch (e) {
    statusRequest = StatusRequest.failure;
    print(e); // Consider logging the error
  }
  update(); // Update UI after fetching data
}


void cancelTrip()async{
driverid=myServices.sharedPreferences.getInt("id");
  var response = await tripDetalisData.cancel(tripid!,driverid!);
}

}