

import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class OtpCode {
  Crud crud;
  OtpCode(this.crud);
  postdata(String phone ,String otp) async {
    var response = await crud.postData(
        AppLink.otpcode, {"phone": phone, "otp": otp});
    return response.fold((l) => l, (r) => r);
  }

  resendData(String phone) async {
    var response = await crud.postData(AppLink.resend, {"phone": phone});
    return response.fold((l) => l, (r) => r);
  }

  sendtoken(String driverid,String token) async {
    var response = await crud.postData(AppLink.token, {"driverid": driverid,"token":token});
    return response.fold((l) => l, (r) => r);
  }
}
