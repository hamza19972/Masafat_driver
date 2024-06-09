
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class TranData {
  Crud crud;
  TranData(this.crud);
  getData(int driverid) async {
    var response = await crud.postData(AppLink.transaction, {"driverid":driverid.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
