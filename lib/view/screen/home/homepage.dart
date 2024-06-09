import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/homepage_controller.dart';
import 'package:masafat_captain/core/class/statusrequest.dart';
import 'package:masafat_captain/view/widget/home/drawerone.dart';

class HomePage extends StatelessWidget {
  final TripController instructionController = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          instructionController.checkBalance();
        },
        child: Icon(Icons.add),
      ),
      drawer: const Drawer(
        child: Drawerone(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '50'.tr,
          style: const TextStyle(color: Colors.green),
        ),
      ),
      body: Obx(() {
        // Check if data has already been loaded
        if (instructionController.statusRequest.value == StatusRequest.loading &&
            instructionController.instructions.isNotEmpty) {
          // Data has been loaded, show the list
          return ListView.builder(
            itemCount: instructionController.instructions.length,
            itemBuilder: (context, index) {
              final instruction = instructionController.instructions[index];
              return ListTile(
                title: Text(instruction.instruction),
                // subtitle: Text('Number: ${instruction.number}'),
              );
            },
          );
        } else {
          // Data hasn't been loaded yet, show loading indicator or error message
          switch (instructionController.statusRequest.value) {
            case StatusRequest.loading:
              return Center(child: CircularProgressIndicator());
            case StatusRequest.failure:
              return Center(child: Text('88'.tr));
            default:
              return ListView.builder(
            itemCount: instructionController.instructions.length,
            itemBuilder: (context, index) {
              final instruction = instructionController.instructions[index];
              return ListTile(
                title: Text(instruction.instruction),
                // subtitle: Text('Number: ${instruction.number}'),
              );
            },
          ); // or some other fallback UI
          }
        }
      }),
    );
  }
}

