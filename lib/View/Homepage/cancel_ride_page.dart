import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/RideDetailsController.dart'; // Make sure this path is correct

class CancelRidePage extends StatelessWidget {
  final List<String> reasons = [
    'Waiting for long time',
    'Unable to connect driver',
    'Driver denied to go to the destination',
    'Driver denied to come to pickup',
    'Wrong address shown',
    'The price is not reasonable',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideDetailsController>(
      init: RideDetailsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                // Handle back button press
              },
            ),
            title: const Text(
              'Cancel Ride',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Please Select the reason of cancellation',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...reasons.map((reason) => _buildReasonItem(context, controller, reason)).toList(),
                        const SizedBox(height: 20),
                        const Text(
                          'Other',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            onChanged: (text) {
                              controller.selectReason('Other');
                              controller.updateOtherReason(text);
                            },
                            maxLines: 3, // Changed from 5 to 3 to make it smaller
                            decoration: const InputDecoration.collapsed(
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final selected = controller.selectedReason.value;
                      final otherText = controller.otherReasonText.value;
                      print('Selected Reason: $selected');
                      if (selected == 'Other' && otherText.isNotEmpty) {
                        print('Other reason text: $otherText');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDC500),
                      foregroundColor: Colors.white, // Changed button text color to white
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReasonItem(BuildContext context, RideDetailsController controller, String reason) {
    return Obx(
          () {
        bool isSelected = controller.selectedReason.value == reason;
        return GestureDetector(
          onTap: () {
            controller.selectReason(reason);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFF7E0) : Colors.white,
              border: Border.all(
                color: isSelected ? const Color(0xFFFDC500) : Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                  color: isSelected ? Colors.green : Colors.grey, // Changed check box color to green
                ),
                const SizedBox(width: 10),
                Text(reason),
              ],
            ),
          ),
        );
      },
    );
  }
}