import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/core/constant/routes.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyAccountPage extends StatelessWidget {
  MyServices myServices = Get.find();
  // Replace the following URL with your WhatsApp number link
  final String whatsappUrl =
      "https://wa.me/<00962771643128>?text=I%20need%20help%20with%20account%20verification";

  // This method is used to launch the WhatsApp URL
  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                myServices.sharedPreferences.clear();
                Get.offAllNamed(AppRoute.welcome);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
        title: Text(
          '53'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Using a green theme for the AppBar
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/whatsapp_icon.svg', // Path to your SVG file in your assets folder
              height: 100.0, // Set the size as you need
              width: 100.0,
            ),
            const SizedBox(height: 20),
            Text(
              '23'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.chat),
              label: Text('54'.tr),
              onPressed: () => _launchURL(whatsappUrl),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Button background color
                onPrimary: Colors.white, // Button text color
                textStyle: const TextStyle(fontSize: 16),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
