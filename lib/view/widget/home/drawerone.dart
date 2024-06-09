import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/drawercontrtoller.dart';
import 'package:masafat_captain/core/constant/color.dart';
import 'package:masafat_captain/view/screen/mytrip.dart';
import 'package:masafat_captain/view/screen/mytripv2.dart';
import 'package:masafat_captain/view/screen/wallet.dart';
import 'package:url_launcher/url_launcher.dart';


class Drawerone extends StatelessWidget {
  const Drawerone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Get.put(UserController());
    
    return GetBuilder<UserController>(
      builder:(userController) =>  ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
           UserAccountsDrawerHeader(
                accountName: Text(userController.username!),
                accountEmail:  Text("0${userController.phone}"),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "M",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                ),
              ),
          // ListTile(
            
          //   leading: SizedBox(
          //       width: 30, // Define a suitable width
          //       height: 30, // Define a suitable height
          //       child:
          //           SvgPicture.asset("assets/images/home.svg", fit: BoxFit.fill)),
          //   title: const Text('Home'),
          //   onTap: () {
          //     // Update the state of the app
          //     // Then close the drawer
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.drive_eta),
            title:  Text('63'.tr),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Get.to(()=>TripsPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title:  Text('61'.tr),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Get.to(()=>WalletPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title:  Text('64'.tr),
            onTap: () {
              launchUrl(Uri.parse("tel:00962771643128"));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title:  Text('65'.tr),
            onTap: () {
             userController.logOut();
            },
          ),
        ],
      ),
    );
  }
}
