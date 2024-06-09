import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class TripData {
  Crud crud;
  TripData(this.crud);
  getinstructions() async {
    var response = await crud.postData(AppLink.tripsview, {});
    return response.fold((l) => l, (r) => r);
  }

  paytrip(int driverid,String tripid) async {
    var response = await crud.postData(AppLink.buytrip, {
      // "price": price.toString(),
      "driverId": driverid.toString(),
      "tripId": tripid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  balance(int driverid) async {
    var response = await crud.postData(AppLink.checkBalance, {"id": driverid.toString()});
    return response.fold((l) => l, (r) => r);
  }

  sendtoken(int driverid) async {
    var response = await crud.postData(AppLink.checkBalance, {"id": driverid.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
