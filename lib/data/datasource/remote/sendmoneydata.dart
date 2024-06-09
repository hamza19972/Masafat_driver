
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class SendWalletData {
  Crud crud;
  SendWalletData(this.crud);
  postData(int senderphone,String receiverphone,String amount) async {
    var response = await crud.postData(AppLink.sendfund, {
    "senderphone":senderphone.toString(),
    "receiverphone":receiverphone,
    "amount":amount,

    });
    return response.fold((l) => l, (r) => r);
  }
}
