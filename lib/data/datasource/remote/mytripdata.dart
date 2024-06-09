
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class MyTripData {
  Crud crud;
  MyTripData(this.crud);
  getData(int driverId) async {
    var response = await crud.postData(AppLink.mytrip, {
      "driverId":driverId.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

  getDataV2(int id) async {
    var response = await crud.postData(AppLink.mytripsv2, {
      "id":id.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

   getpasstrip(String trip_id) async {
    var response = await crud.postData(AppLink.viewpasstrip, {
      "trip_id":trip_id
    });
    return response.fold((l) => l, (r) => r);
  }

  canceleTrip(String trip_id) async {
    var response = await crud.postData(AppLink.canceleTrip, {
      "trip_id":trip_id
    });
    return response.fold((l) => l, (r) => r);
  }

  fulltrip(String trip_id) async {
    var response = await crud.postData(AppLink.fullTrip, {
      "id":trip_id
    });
    return response.fold((l) => l, (r) => r);
  }
}
