
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class GetWalletData {
  Crud crud;
  GetWalletData(this.crud);
  getData(int phone) async {
    var response = await crud.postData(AppLink.walletView, {
      "phone":phone.toString()
    });
    return response.fold((l) => l, (r) => r);
  }
}
