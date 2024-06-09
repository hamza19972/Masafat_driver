import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/routes_data.dart';

class RouteModel {
  final int routeID;
  final String startProvince;
  final String endProvince;

  RouteModel({
    required this.routeID,
    required this.startProvince,
    required this.endProvince,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
  return RouteModel(
    routeID: int.parse(json['RouteID'].toString()),
    startProvince: json['StartProvince'],
    endProvince: json['EndProvince'],
  );
}
}


class RoutesController extends GetxController {
  var routes = <RouteModel>[].obs;
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();
  RoutesData routesData = RoutesData(Get.find());

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update(); // Notify listeners to show loading state

    try {
    var response = await routesData.getData();
    print("=============================== Controller $response");

    if (response['status'] == "success") {
      // Assuming the data is a List of Maps
      List<dynamic> routeData = response['data'];
      var fetchedRoutes = routeData.map((json) => RouteModel.fromJson(json)).toList();
      routes.assignAll(fetchedRoutes); // Correctly adds fetched routes to the observable list
  
      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;
    }
  } catch (e) {
    print('Error fetching data: $e');
    statusRequest = StatusRequest.failure;
  }

  update(); // Notify listeners to update UI based on the new statusRequest and data
}
}
