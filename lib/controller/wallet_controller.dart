import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/core/functions/handingdatacontroller.dart';
import 'package:masafat_captain/core/services/services.dart';
import 'package:masafat_captain/data/datasource/remote/getwalletdata.dart';
import 'package:masafat_captain/data/datasource/remote/sendmoneydata.dart';
import 'package:masafat_captain/data/datasource/remote/transactiondata.dart';

class TransactionResponse {
  String status;
  List<Transaction> data;

  TransactionResponse({required this.status, required this.data});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      status: json['status'],
      data: List<Transaction>.from(json['data'].map((x) => Transaction.fromJson(x))),
    );
  }
}

class Transaction {
  int? transactionId;
  int? senderDriverId;
  int? receiverDriverId;
  double amount;
  String transactionDate;
  String type;

  Transaction({
    required this.transactionId,
    this.senderDriverId,
    this.receiverDriverId,
    required this.amount,
    required this.transactionDate,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['TransactionID'],
      senderDriverId: json['SenderDriverID'] != null 
          ? (json['SenderDriverID'] is int ? json['SenderDriverID'] : int.tryParse(json['SenderDriverID'])) 
          : null,
      receiverDriverId: json['ReceiverDriverID'] != null 
          ? (json['ReceiverDriverID'] is int ? json['ReceiverDriverID'] : int.tryParse(json['ReceiverDriverID'])) 
          : null,
      amount: json['Amount'] is double ? json['Amount'] : double.parse(json['Amount'].toString()),
      transactionDate: json['TransactionDate'],
      type: json['Type'],
    );
  }
}




class Driver {
  final int driverId;
  final String driverName;
  final int otp;
  final int driverAdmin;
  final int driverDocument;
  final int otpApproved;
  final int driverPhone;
  final String walletBalance;

  Driver({
    required this.driverId,
    required this.driverName,
    required this.otp,
    required this.driverAdmin,
    required this.driverDocument,
    required this.otpApproved,
    required this.driverPhone,
    required this.walletBalance,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driver_id'],
      driverName: json['driver_name'],
      otp: json['otp'],
      driverAdmin: json['driver_admin'],
      driverDocument: json['driver_doucment'], // Note the typo in 'document'
      otpApproved: json['otp_approved'],
      driverPhone: json['driver_phone'],
      walletBalance: json['WalletBalance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver_id': driverId,
      'driver_name': driverName,
      'otp': otp,
      'driver_admin': driverAdmin,
      'driver_doucment': driverDocument, // Keeping the original typo
      'otp_approved': otpApproved,
      'driver_phone': driverPhone,
      'WalletBalance': walletBalance,
    };
  }
}

class WalletController extends GetxController {
  MyServices myServices = Get.find();

  String? balance;

  GetWalletData getWalletData = GetWalletData(Get.find());
  SendWalletData sendWalletData = SendWalletData(Get.find());
  TranData tranData = TranData(Get.find());

  List data = [];

  late StatusRequest statusRequest;

  TextEditingController amountController = TextEditingController();
  TextEditingController driverIdController = TextEditingController();
    RxList<Transaction> transactions = <Transaction>[].obs;


  @override
  void onInit() {
    getData();
    getTran();
    super.onInit();
  }

  getData() async {
    statusRequest = StatusRequest.loading;
    int? phone = myServices.sharedPreferences.getInt("phone");

    var response = await getWalletData.getData(phone!);

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        if (response['data'][0]['WalletBalance'] != null &&
            response['data'].isNotEmpty) {
          balance = response['data'][0]['WalletBalance'];
          update();
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
        // End
      }
      update();
    }
  }

  void showTransferFundsDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('25'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: driverIdController,
              decoration: InputDecoration(labelText: '26'.tr,hintText: '27'.tr),
              keyboardType: TextInputType.number,
              
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: '28'.tr),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('29'.tr),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('30'.tr),
            onPressed: () {
              transferFunds();
              getTran();
              update();
              Get.back(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }

  transferFunds() async {
    int? phone = myServices.sharedPreferences.getInt("phone");

    statusRequest = StatusRequest.loading;

    var response = await sendWalletData.postData(
        phone!, driverIdController.text, amountController.text);

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        getData();
        Get.showSnackbar(GetSnackBar(
          message: "33".tr,
          duration: Duration(seconds: 2),
        ));
        update();
      } else if (response['status'] == "failure") {
        String message = "31".tr;

        // Check if the failure message is about insufficient funds
        if (response['message'] == "Insufficient funds.") {
          message = "32".tr;
        }

        Get.showSnackbar(
          GetSnackBar(
            message: message, // Use the specific failure message
            duration: Duration(seconds: 2),
          ),
        );
      }
      statusRequest = StatusRequest.failure;
    }
    // End
  }

  void getTran() async {
  statusRequest = StatusRequest.loading;
  int? driverid = myServices.sharedPreferences.getInt("id");

  var response = await tranData.getData(driverid!);

  print("=============================== Tran $response ");

  statusRequest = handlingData(response);

  if (StatusRequest.success == statusRequest) {
    if (response['status'] == "success") {
      List<dynamic> transactionData = response['data'];

      // Convert each transaction to a Transaction object and parse the date
      var transactionsList = transactionData.map((data) {
        var trans = Transaction.fromJson(data);
        return trans;
      }).toList();

      // Sort the transactions by date in descending order
      transactionsList.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));

      // Assign the sorted list to the observable list
      transactions.assignAll(transactionsList);
    }
  }
  update();
}
}