import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/viewuserinfo.dart';
import 'package:url_launcher/url_launcher.dart';

class Passrequcontroller extends GetxController {
  MyServices myServices = Get.find();
  StatusRequest? statusRequest;
  viewUserInfo viewuserinfo = viewUserInfo(Get.find());
  int? driverId;
  String? status;
  int? tridId;

  @override
  void onInit() {
    super.onInit();
    driverId = myServices.sharedPreferences.getInt("id");
  }

  buyPass(String price,String bookingid) async {
    statusRequest = StatusRequest.loading;
    update();
    String id = driverId.toString();
    try {
      var response = await viewuserinfo.buyPass(id, price,bookingid);
      print("=============================== Controller $response ");

      if (response['status'] == "success") {
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  driverResponse(String bookingid) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await viewuserinfo.driverResponse(bookingid, status!,driverId.toString());
      print("=============================== Controller $response");
      if (response['status'] == "success") {
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  fullTrip(String tridId) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await viewuserinfo.getData(tridId);
      print("=============================== Controller $response");
      if (response['status'] == "success") {
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  void launchMap(String coordinates) async {
    final latLng = _parseCoordinates(coordinates);
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latLng');
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  String _parseCoordinates(String coordinates) {
    final regex = RegExp(r'([-+]?[0-9]*\.?[0-9]+) ([-+]?[0-9]*\.?[0-9]+)');
    final match = regex.firstMatch(coordinates);
    if (match != null) {
      final lat = match.group(1);
      final lng = match.group(2);
      return '$lat,$lng';
    } else {
      throw 'Invalid coordinates format';
    }
  }
}
