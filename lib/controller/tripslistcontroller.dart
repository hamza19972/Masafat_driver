import 'package:get/get.dart';

class TripCreationController extends GetxController {
  var selectedDate = 'Today'.obs;
  var fromCity = ''.obs;
  var toCity = ''.obs;
  var maleSeats = 1.obs;
  var femaleSeats = 1.obs;
  var startTime = '00:00'.obs;
  var tripPathFrom = ''.obs;
  var tripPathTo = ''.obs;

  final List<String> cities = [
    'الكرك',
    'عمان',
    'الطفيلة',
    'إربد',
    'العقبة',
    'المفرق',
    'معان',
    'الزرقاء',
    'السلط',
    'مأدبا',
    'عجلون',
    'جرش'
  ];
  final List<int> seats = List.generate(4, (index) => index + 1);
  final List<String> times = List.generate(24, (index) => "${index.toString().padLeft(2, '0')}:00");

  void setDate(String value) => selectedDate.value = value;
  void setFromCity(String value) => fromCity.value = value;
  void setToCity(String value) => toCity.value = value;
  void setMaleSeats(int value) => maleSeats.value = value;
  void setFemaleSeats(int value) => femaleSeats.value = value;
  void setStartTime(String value) => startTime.value = value;
  void setTripPathFrom(String value) => tripPathFrom.value = value;
  void setTripPathTo(String value) => tripPathTo.value = value;
}
