import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/tripsdata.dart';
import 'package:masafat_captain/view/screen/home/addtrip.dart';

class Instruction {
  int id;
  int number;
  String instruction;

  Instruction({
    required this.id,
    required this.number,
    required this.instruction,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      id: json['id'],
      number: json['number'],
      instruction: json['instruction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'instruction': instruction,
    };
  }
}


class InstructionResponse {
  String status;
  List<Instruction> data;

  InstructionResponse({
    required this.status,
    required this.data,
  });

  factory InstructionResponse.fromJson(Map<String, dynamic> json) {
    return InstructionResponse(
      status: json['status'],
      data: List<Instruction>.from(
        json['data'].map((x) => Instruction.fromJson(x))
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}


class TripController extends GetxController {
  int? driverId;
  AudioPlayer audioPlayer = AudioPlayer();
  var statusRequest = StatusRequest.loading.obs;
  TripData tripData = TripData(Get.find());
  MyServices myServices = Get.find();
  var instructions = <Instruction>[].obs;

  @override
  void onInit() {
    driverId = myServices.sharedPreferences.getInt("id");
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    statusRequest.value = StatusRequest.loading;
    update();

    try {
      var response = await tripData.getinstructions();
      print("=============================== Controller $response ");

      if (response['status'] == "success") {
        instructions.value = (response['data'] as List)
            .map((e) => Instruction.fromJson(e))
            .toList();
        statusRequest.value = StatusRequest.success;
      } else {
        statusRequest.value = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest.value = StatusRequest.failure;
    }

    update();
  }

  void checkBalance() async {
    statusRequest.value = StatusRequest.loading;
    update();

    try {
      var response = await tripData.balance(driverId!);
      print("=============================== Controller $response ");

      if (response['status'] == "success") {
        Get.to(() => RoutesPage());
      } else {
        Get.defaultDialog(
            middleText: "75".tr);
        statusRequest.value = StatusRequest.failure;
      }
    } catch (e) {
      print('Error fetching data: $e');
      statusRequest.value = StatusRequest.failure;
    }

    update();
  }
}