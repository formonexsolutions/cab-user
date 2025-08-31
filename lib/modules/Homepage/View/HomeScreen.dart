import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/CustomDrawer.dart';
import '../Controller/HomeController.dart';
import 'package:flutter_map/flutter_map.dart';
import '../Widgets/CommonWidget.dart';
import '../Widgets/cabFindingWidget.dart';
import '../Widgets/pickupDropWidget.dart';
import '../Widgets/vehicleTypeWidget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Obx(
                () => controller.currentLocation.value == null
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: controller.currentLocation.value!,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.car_travel',
                ),
                MarkerLayer(
                  markers: controller.markers.toList(),
                ),
              ],
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: SafeArea(
              child: Builder(
                builder: (BuildContext innerContext) {
                  return Obx(
                        () {
                      if (controller.isRideSelectionVisible.value) {
                        // Condition 2: Show back button on left, menu on right
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            buildCircularIconButton(
                              icon: Icons.arrow_back_ios,
                              onPressed: () => controller.hideRideSelection(),
                            ),
                            // Menu Button for the RIGHT drawer
                            buildCircularIconButton(
                              icon: Icons.menu,
                              onPressed: () => Scaffold.of(innerContext).openDrawer(),
                            ),
                          ],
                        );
                      } else {
                        // Condition 1: Show single menu button on left
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: buildCircularIconButton(
                            icon: Icons.menu,
                            onPressed: () => Scaffold.of(innerContext).openDrawer(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Obx(() {
            final size = getSheetSize();
            return DraggableScrollableSheet(
              initialChildSize: size,
              minChildSize: size,
              maxChildSize: size,
              builder: (BuildContext context, ScrollController scrollController) {
                return Obx(() {
                  if (controller.isSearchingForRide.value) {
                    return buildSearchingPanel(context, scrollController);
                  } else if (controller.isRideSelectionVisible.value) {
                    return buildVehicleSelectionPanel(context, scrollController);
                  } else {
                    return buildWhereToPanel(context, scrollController);
                  }
                });
              },
            );
          })

        ],
      ),
    );
  }
}


