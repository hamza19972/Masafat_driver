import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/routes_data.dart';
import 'package:intl/intl.dart';
import 'package:masafat_captain/view/screen/home/homepage.dart';

class AfterAddController extends GetxController {
  String? DriverID;
  RxInt selectedRoute;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  RxString selectedTimeFormatted = ''.obs;
  RxInt gender = RxInt(1); // 1 for male, 0 for female

  // Initialize selectedRoute with the routeID passed in
  AfterAddController({required int routeID}) : selectedRoute = RxInt(routeID);

  StatusRequest? statusRequest;
  MyServices myServices = Get.find();
  RoutesData routesData = RoutesData(Get.find());

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 1)), // Today and tomorrow only
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final now = DateTime.now();
    final initialTime = TimeOfDay(hour: now.hour, minute: 0);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final selectedDateIsToday = selectedDate.value != null &&
          selectedDate.value!.year == now.year &&
          selectedDate.value!.month == now.month &&
          selectedDate.value!.day == now.day;

      // If the selected date is today, ensure the selected time is in the future
      if (selectedDateIsToday && (picked.hour < now.hour || (picked.hour == now.hour && picked.minute < now.minute))) {
        // Show an error message or handle the invalid time selection
        Get.snackbar(
          '67'.tr,
          '68'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        final roundedHour = TimeOfDay(hour: picked.hour, minute: 0); // Rounded to the nearest hour
        selectedTime.value = roundedHour;
        selectedTimeFormatted.value = formatTimeOfDay(roundedHour);
      }
    }
  }

  // Helper method to format TimeOfDay to "HH:MM:SS"
  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat('HH:mm:ss'); // Use 'HH' for 24-hour format
    return format.format(dt);
  }

  Future<void> postData() async {
    DriverID = myServices.sharedPreferences.getInt("id").toString();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);

    statusRequest = StatusRequest.loading;
    update(); // Notify listeners to show loading state

    try {
      var response = await routesData.postData(
          gender.toString(),
          selectedTimeFormatted.value,
          formattedDate,
          selectedRoute.value.toString(),
          DriverID!);
      print("=============================== Controller $response");

      if (response['status'] == "success") {
        statusRequest = StatusRequest.success;
        var tripID = response['tripID'];
        Get.defaultDialog(
          title: "69".tr,
          middleText: "70".tr,
          onConfirm: () {
            Get.offAll(() => HomePage());
          },
          textConfirm: "71".tr,
        );
      } else {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
          title: "72".tr,
          middleText: "73".tr,
          onConfirm: () {
            Get.back();
          },
          textConfirm: "71".tr,
        );
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(
        title: "72".tr,
        middleText: "74".tr,
        onConfirm: () {
          Get.back();
        },
        textConfirm: "71".tr,
      );
    }

    update(); // Notify listeners to update UI based on the new statusRequest and data
  }
}
