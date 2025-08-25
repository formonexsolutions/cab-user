import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/HomeControllers/search_controller.dart';

class SearchView extends GetView<PlaceSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {

      final PlaceSearchController controller = Get.find<PlaceSearchController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- Top Search Bar ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.yellow, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: controller.updateSearchQuery,
                        decoration: InputDecoration(
                          hintText: 'Shivajinagar, Pune',
                          border: InputBorder.none,
                          // Yeh line add karein
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          suffixIcon: Obx(() =>
                          controller.searchQuery.value.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () {
                              controller.updateSearchQuery('');
                              FocusScope.of(context).unfocus();
                            },
                          )
                              : const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            // --- Recent Places Section Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Places',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.clearRecentPlaces,
                    child: const Text(
                      'Clear All',
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Divider(),
            ),
            // --- Recent Places List ---
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.recentPlaces.length,
                  itemBuilder: (context, index) {
                    final place = controller.recentPlaces[index];
                    return ListTile(
                      onTap: () {
                        // Yahan par changes karein
                        // 'place['name']!' ko return karein aur back navigate karein
                        Get.back(result: place['name']!);
                      },
                      leading: const Icon(Icons.access_time, color: Colors.grey),
                      title: Text(
                        place['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(place['address']!),
                      trailing: Text(place['distance']!),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}