
import 'package:masafat_captain/core/class/crud.dart';
import 'package:masafat_captain/linkapi.dart';

class EditNameData {
  Crud crud;
  EditNameData(this.crud);
  postdata(String name,String surename ,String phone) async {
    var response = await crud.postData(AppLink.updatename, {
      "name" : name , 
      "surename" : surename, 
      "phone" : phone, 
    });
    return response.fold((l) => l, (r) => r);
  }
}