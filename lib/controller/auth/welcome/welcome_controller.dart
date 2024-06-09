
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/constant/routes.dart';
import 'package:masafat_captain/core/functions/handingdatacontroller.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/auth/welcome.dart';

abstract class WelcomeController extends GetxController {
  login();
}

class WelcomeControllerImp extends WelcomeController {
  WelcomeData welcomeData = WelcomeData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController phone;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  initData() {
    phone = TextEditingController();
    // FirebaseMessaging.instance.getToken().then((value) {
    //   print(value);
    //   String? token = value;
    // });
  }

   @override
      void onInit() {
        initData();
        super.onInit();
      }

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await welcomeData.postdata(phone.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.VerfiyOtp,
              arguments: {"phone": phone.text});

          update();
        } else {
          Get.offNamed(AppRoute.VerfiyOtp,
              arguments: {"phone": phone.text});
        }
      }

     

      @override
      void dispose() {
        phone.dispose();
        super.dispose();
      }
    }
  }
}
