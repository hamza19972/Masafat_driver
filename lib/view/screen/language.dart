import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/core/constant/routes.dart';
import 'package:masafat_captain/core/localization/changelocal.dart';
import 'package:masafat_captain/view/widget/language/custombuttomlang.dart'; 

class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(  
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1".tr, style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 20),
              CustomButtonLang(
                  textbutton: "Ar",
                  onPressed: () {
                    controller.changeLang("ar");
                    Get.toNamed(AppRoute.welcome) ; 
                  }),
              CustomButtonLang(
                  textbutton: "En",
                  onPressed: () {
                    controller.changeLang("en");
                    Get.toNamed(AppRoute.welcome) ; 
                  }),
            ],
          )),
    );
  }
}
