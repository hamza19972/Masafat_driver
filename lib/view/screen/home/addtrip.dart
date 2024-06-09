import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masafat_captain/controller/routes_controller.dart';
import 'package:masafat_captain/view/screen/home/afteradd.dart';


class RoutesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize your RoutesController here
     RoutesController routesController = Get.put(RoutesController());

    return Scaffold(
      appBar: AppBar(title: Text('78'.tr)),
      body: Obx(() {
        if (routesController.routes.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: routesController.routes.length,
            itemBuilder: (context, index) {
              final route = routesController.routes[index];
              return ListTile(
                title: Text("من" +" "+route.startProvince),
                subtitle: Text("الى" +" "+route.endProvince),
                onTap: () {
                  Get.to(()=>TripFormPage(routeID: route.routeID,));
                },
              );
            },
          );
        }
      }),
    );
  }
}
