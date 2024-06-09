
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class RoutesData {
  Crud crud;
  RoutesData(this.crud);
  getData() async {
    var response = await crud.postData(AppLink.viewroutes, {});
    return response.fold((l) => l, (r) => r);
  }

  postData(String gender,String DepartureTime,String DepartureDate,String RouteID,String DriverID) async {
    var response = await crud.postData(AppLink.submittrip, {
    "gender":gender,
    "DepartureTime":DepartureTime,
    "DepartureDate":DepartureDate,
    "RouteID":RouteID,
    "DriverID":DriverID,
    });
    return response.fold((l) => l, (r) => r);
  }
}
