import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/passrequcontroller.dart';
import 'package:masafat_captain/view/screen/home/homepage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingScreen extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final String passengerName;
  final String seats;
  final String price;
  final String id;

  BookingScreen({
    required this.pickup,
    required this.dropoff,
    required this.passengerName,
    required this.seats,
    required this.price,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Passrequcontroller controller = Get.put(Passrequcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text('89'.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '90'.tr,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800]),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(
                      context,
                      title: '18'.tr,
                      value: '91'.tr,
                      icon: Icons.location_on,
                      onTap: () => controller.launchMap(pickup),
                    ),
                    Divider(color: Colors.blueGrey[200]),
                    _buildDetailItem(
                      context,
                      title: '17'.tr,
                      value: '91'.tr,
                      icon: Icons.location_on,
                      onTap: () => controller.launchMap(dropoff),
                    ),
                    Divider(color: Colors.blueGrey[200]),
                    _buildDetailItem(
                      context,
                      title: '92'.tr,
                      value: seats,
                      icon: Icons.event_seat_outlined,
                    ),
                    Divider(color: Colors.blueGrey[200]),
                    _buildDetailItem(
                      context,
                      title: '93'.tr,
                      value: price,
                      icon: Icons.attach_money,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Column(
              children: [
                _buildGradientButton(
                  context,
                  label: '94'.tr,
                  icon: Icons.cancel,
                  gradientColors: [Colors.red, Colors.redAccent],
                  onPressed: () {
                    _showConfirmationDialog(context,
                        title: '95'.tr,
                        content:
                            '96'.tr,
                        onConfirm: () {
                      controller.status = "declined";
                      controller.driverResponse(id);
                      Get.offAll(() => HomePage());
                    });
                  },
                ),
                SizedBox(height: 16),
                _buildGradientButton(
                  context,
                  label: '97'.tr,
                  icon: Icons.check_circle,
                  gradientColors: [Colors.green, Colors.greenAccent],
                  onPressed: () {
                    _showConfirmationDialog(
                      context,
                      title: '98'.tr,
                      content: '99'.tr,
                      onConfirm: () {
                        controller.status = "confirmed";
                        controller.driverResponse(id);
                        controller.buyPass(price,id);
                        Get.offAll(() => HomePage());
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueGrey[800]),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '$title:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 18,
                  color: onTap != null ? Colors.blue : Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: content,
      buttons: [
        DialogButton(
          child: Text(
            "29".tr,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "59".tr,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          gradient: LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
        ),
      ],
    ).show();
  }
}
