// UserController.dart
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/constant/routes.dart';
import 'package:masafat_captain/core/services/services.dart';


class UserController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  int? phone;
  String? username;

  @override
  void onInit() {
    
    username = myServices.sharedPreferences.getString("username");
    phone = myServices.sharedPreferences.getInt("phone");
    super.onInit();
  }

  void logOut(){
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.welcome);
  }
}
