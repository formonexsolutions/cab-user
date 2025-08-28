import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/app_colors.dart';
import '../../controllers/RideControllers/all_rides_controller.dart';
import '../../widgets/RideCardWidget.dart';


class AllRidesPage extends StatelessWidget {
  final AllRidesController controller = Get.put(AllRidesController());

  AllRidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          title: const Text(
            'All Rides',
            style: TextStyle(color: AppColors.headlineTextColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.hintTextColor,
            indicatorColor: AppColors.primaryBlue,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'All Rides'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
            onTap: (index) {
              // Add logic here if needed
            },
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => _buildRideList(controller.allRides)),
            Obx(() => _buildRideList(controller.completedRides)),
            Obx(() => _buildRideList(controller.canceledRides)),
          ],
        ),
      ),
    );
  }

  Widget _buildRideList(RxList<Ride> rides) {
    if (rides.isEmpty) {
      return const Center(child: Text('No rides found.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: rides.length,
      itemBuilder: (context, index) {
        return RideCardWidget(ride: rides[index]);
      },
    );
  }
}