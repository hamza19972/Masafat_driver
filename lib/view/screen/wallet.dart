import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/wallet_controller.dart';

class WalletPage extends StatelessWidget {
  final WalletController walletController = Get.put(WalletController());

  WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('61'.tr),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GetBuilder<WalletController>(
            builder: (controller) {
              // Checking for null balance
              if (controller.balance == null) {
                return const Center(child: CircularProgressIndicator(color: Colors.green),);
              }
              // Displaying the balance card
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        '62'.tr,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'JOD ${controller.balance}',
                        style: TextStyle(fontSize: 36, color: controller.balance=="0.00"?Colors.red :Colors.green),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: GetBuilder<WalletController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.transactions[index];
                    return ListTile(
                      title: Text(transaction.type),
                      subtitle: Text(transaction.transactionDate),
                      trailing: Text('JOD ${transaction.amount}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          walletController.showTransferFundsDialog(context);
        },
        child: const Icon(Icons.compare_arrows_outlined),
      ),
    );
  }
}
