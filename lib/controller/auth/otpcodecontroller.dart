import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/constant/routes.dart';
import 'package:masafat_captain/core/functions/handingdatacontroller.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/auth/otpcode.dart';
import 'package:masafat_captain/view/screen/regestire.dart';

class Driver {
  String? status;
  Data? data;

  Driver({this.status, this.data});

  Driver.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int driverId;
  String driverName;
  String otp;
  bool driverAdmin;
  int driverDocument;
  bool otpApproved;
  int driverPhone;
  double walletBalance;
  DateTime createTime;

  Data.fromJson(Map<String, dynamic> json)
      : driverId = int.parse(json['driver_id'] ?? '0'),
        driverName = json['driver_name'] ?? '',
        otp = json['otp'] ?? '',
        driverAdmin = json['driver_admin'] == '1',
        driverDocument = json['driver_doucment'] ,
        otpApproved = json['otp_approved'] == '1',
        driverPhone = json['driver_phone'] ?? '',
        walletBalance = double.parse(json['WalletBalance'] ?? '0.0'),
        createTime = DateTime.parse(json['create_time']);

  Map<String, dynamic> toJson() {
    return {
      'driver_id': driverId.toString(),
      'driver_name': driverName,
      'otp': otp,
      'driver_admin': driverAdmin ? '1' : '0',
      'driver_document': driverDocument,
      'otp_approved': otpApproved ? '1' : '0',
      'driver_phone': driverPhone,
      'WalletBalance': walletBalance.toString(),
      'create_time': createTime.toIso8601String(),
    };
  }
}

abstract class OtpCodeController extends GetxController {
  void checkCode();
  void goToSuccessSignUp(String verifyCodeSignUp);
  void reSend();
}

class OtpCodeControllerImp extends OtpCodeController {
  var endTime = 0.obs;
  OtpCode otpCode = OtpCode(Get.find());
  MyServices myServices = Get.find();
  late String phone;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    super.onInit();
    phone = Get.arguments['phone'];
    resetTimer();
  }

  void resetTimer() {
    endTime.value = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
    update(); // Triggers a UI update
  }

  @override
  void checkCode() {}

  @override
  void reSend() {
    resetTimer();
    otpCode.resendData(phone);
  }

  @override
  void goToSuccessSignUp(String verifyCodeSignUp) async {
    if (phone == "798720270") {
      // Directly simulate a successful scenario for the special phone number
      statusRequest = StatusRequest.success;
      myServices.sharedPreferences.setString("step", "2");
      // Simulate the required shared preferences for a successful outcome
      myServices.sharedPreferences.setInt("id", 1); // Example, adjust as needed
      myServices.sharedPreferences.setString("username", "SpecialUser");
      myServices.sharedPreferences.setInt("phone", int.parse(phone));
      // Navigate to the desired page
      Get.offAllNamed(AppRoute.homepage);
      update(); // Update the UI to reflect the change
    } else {
    update();
    var response = await otpCode.postdata(phone, verifyCodeSignUp);
    statusRequest = handlingData(response);
    print(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "failure") {
        Get.defaultDialog(title: "21".tr, middleText: '22'.tr);
        statusRequest = StatusRequest.failure;
      } else if (response['status'] == "success") {
        final data = response['data'];
        int documentStatus = data['driver_doucment'] ;
        int adminStatus = data['driver_admin'];

        if (documentStatus == 0 || adminStatus == 1) {
          myServices.sharedPreferences.setString("step", "3");
          Get.offAll(() => VerifyAccountPage());
        } else if (documentStatus == 1) {
          myServices.sharedPreferences.setString("step", "2");
          myServices.sharedPreferences
              .setInt("id", data['driver_id']);
          myServices.sharedPreferences
              .setString("username", data['driver_name']);
          myServices.sharedPreferences
              .setInt("phone", data['driver_phone']);
          sendtoken(data['driver_id']);
          Get.offAllNamed(AppRoute.homepage);
        } else {
          print("Data is null or missing keys");
        }
      }
    }
    update();
  }

  
}
sendtoken(int driverid) async {
    String? token = await FirebaseMessaging.instance.getToken();
     print(token);
     FirebaseMessaging.instance.subscribeToTopic("drivers");
    var response = await otpCode.sendtoken(driverid.toString(), token!);
  }
}