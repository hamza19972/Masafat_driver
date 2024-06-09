
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class TripDetalisData{
  Crud crud;
  TripDetalisData(this.crud);
  getData(int tripid) async {
    var response = await crud.postData(AppLink.tripdetalis, {
     "tripid":tripid.toString()
      
    });
    return response.fold((l) => l, (r) => r);
  }

  cancel(int tripid,int driverid) async {
    var response = await crud.postData(AppLink.cancel, {
     "tripid":tripid.toString(),
     "driverid":driverid.toString(),
      
    });
    return response.fold((l) => l, (r) => r);
  }
}
