class driverModel {
  int? driverId;
  String? driverName;
  int? otp;
  int? driverAdmin;
  int? driverDoucment;
  int? otpApproved;
  int? driverPhone;

  driverModel(
      {this.driverId,
      this.driverName,
      this.otp,
      this.driverAdmin,
      this.driverDoucment,
      this.otpApproved,
      this.driverPhone});

  driverModel.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    otp = json['otp'];
    driverAdmin = json['driver_admin'];
    driverDoucment = json['driver_doucment'];
    otpApproved = json['otp_approved'];
    driverPhone = json['driver_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['otp'] = this.otp;
    data['driver_admin'] = this.driverAdmin;
    data['driver_doucment'] = this.driverDoucment;
    data['otp_approved'] = this.otpApproved;
    data['driver_phone'] = this.driverPhone;
    return data;
  }
}