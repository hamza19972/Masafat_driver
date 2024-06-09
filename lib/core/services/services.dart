import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyServices extends GetxService {
  
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    _requestNotificationPermission();
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print('Notification permission granted.');
    } else if (status.isDenied || status.isPermanentlyDenied) {
      print('Notification permission denied.');
      // Optionally show an alert dialog or a message to the user
    }
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
 

  
}
