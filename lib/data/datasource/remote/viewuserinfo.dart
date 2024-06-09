
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class viewUserInfo {
  Crud crud;
  viewUserInfo(this.crud);
  getData(String id) async {
    var response = await crud.postData(AppLink.fullTrip, {"id":id});
    return response.fold((l) => l, (r) => r);
  }

  driverResponse(String id,String status,String driverID) async {
    var response = await crud.postData(AppLink.driverResponse, {"id":id,"status":status,"driverID":driverID});
    return response.fold((l) => l, (r) => r);
  }

   buyPass(String id,String price,String bookingid) async {
    var response = await crud.postData(AppLink.buyPass, {"id":id,"price":price,"bookingid":bookingid});
    return response.fold((l) => l, (r) => r);
  }
}
