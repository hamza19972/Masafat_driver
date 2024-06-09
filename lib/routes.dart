
import 'package:get/get.dart';
import 'package:masafat_captain/core/constant/routes.dart';
import 'package:masafat_captain/core/middleware/mymiddleware.dart';
import 'package:masafat_captain/view/screen/auth/verfiyotp.dart';
import 'package:masafat_captain/view/screen/auth/welcome.dart';
import 'package:masafat_captain/view/screen/home/homepage.dart';
import 'package:masafat_captain/view/screen/language.dart';
import 'package:masafat_captain/view/screen/regestire.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const Language(), middlewares: [MyMiddleWare()]),
  // GetPage(name: "/", page: () =>   TestView()),
//  Auth
  GetPage(name: AppRoute.welcome, page: () => Welcome()),
  GetPage(name: AppRoute.homepage, page: () => HomePage()),
  // GetPage(name: AppRoute.login, page: () => const Login()),

  GetPage(name: AppRoute.VerfiyOtp, page: () => const VerfiyOtp()),
  GetPage(name: AppRoute.register, page: () =>   VerifyAccountPage()),
  //
  // GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),

  // GetPage(name: AppRoute.addressadddetails, page: () => const AddressAddDetails()),
];
