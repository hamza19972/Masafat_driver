import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:masafat_captain/bindings/intialbindings.dart';
import 'package:masafat_captain/core/localization/translation.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/routes.dart';
import 'package:masafat_captain/view/screen/home/passrequ.dart';
import 'core/localization/changelocal.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  setupFlutterNotifications();
  print('Handling a background message: ${message.messageId}');
  // Only show local notification if the app is terminated
  if (message.data.isNotEmpty) {
    // _showLocalNotification(message);
  }
}

Future<void> setupFlutterNotifications() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'masafatid', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    sound: RawResourceAndroidNotificationSound('aa'),
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

// void _showLocalNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode, // Ensure the notification ID is unique
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           'masafatid',
//           'High Importance Notifications',
//           channelDescription: 'This channel is used for important notifications.',
//           icon: 'launch_background',
//           sound: RawResourceAndroidNotificationSound('aa'),
//         ),
//       ),
//       payload: jsonEncode(message.data), // Include payload with the notification data
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialServices();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // final InitializationSettings initializationSettings =
    //     InitializationSettings(
    //   android: initializationSettingsAndroid,
    // );
    // // flutterLocalNotificationsPlugin.initialize(
    // //   initializationSettings,
    // //   onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
    // //     if (notificationResponse.payload != null) {
    // //       Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
    // //       showBookingScreen(data);
    // //     }
    // //   },
    // // );

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        Map<String, dynamic> data = message.data;
       if (message.data.containsKey('pickup') &&
        message.data.containsKey('dropoff')) {
      // Only proceed if the required data is present
      showBookingScreen(data);
    }
      }
    });

FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        if (message.data.containsKey('pickup') &&
        message.data.containsKey('dropoff')) {
      // Only proceed if the required data is present
      showBookingScreen(message.data);
    }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data != null) {
        Map<String, dynamic> data = message.data;
        if (message.data.containsKey('pickup') &&
        message.data.containsKey('dropoff')) {
      // Only proceed if the required data is present
      showBookingScreen(message.data);
    }
      }
    });

    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'MASAFAT_CAPTAIN',
      locale: controller.language,
      theme: controller.appTheme,
      initialBinding: InitialBindings(),
      getPages: routes,
    );
  }
}

Future<void> showBookingScreen(Map<String, dynamic> data) async {
  Get.offAll(() => BookingScreen(
    pickup: data['pickup'],
    dropoff: data['dropoff'],
    passengerName: data['name'],
    seats: data['seatsBooked'],
    price: data['price'],
    id: data['id'],
  ));
}
