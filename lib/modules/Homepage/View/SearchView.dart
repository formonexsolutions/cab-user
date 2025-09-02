import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Utils/app_colors.dart';
import '../Controller/HomeController.dart';
import '../Controller/search_controller.dart';

class SearchView extends GetView<PlaceSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaceSearchController controller = Get.find<PlaceSearchController>();
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- Top Search Bar ----------------
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.searchFieldYellowBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: controller.updateSearchQuery,
                        decoration: InputDecoration(
                          hintText: 'Search destination',
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.close,
                                color: Colors.grey),
                            onPressed: () {
                              controller.updateSearchQuery('');
                              FocusScope.of(context).unfocus();
                            },
                          )
                              : const SizedBox()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------------- Recent Places Header ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      style: TextStyle(
                          color: AppColors.buttonTextYellow,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[400]),

            // ---------------- Results or Recent List ----------------
            Expanded(
              child: Obx(() {
                final isLoading = controller.isLoading.value;
                final results = controller.searchResults;
                final hasQuery = controller.searchQuery.value.isNotEmpty;
                final recent = controller.recentPlaces;

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (hasQuery && results.isNotEmpty) {
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final place = results[index];
                      return ListTile(
                        onTap: () {
                          // Save to recent and return data
                          controller.addToRecent(place);
                          homeController.selectDestination(result: {
                            'name': place['name'],
                            'lat': double.tryParse(place['latitude']),
                            'long': double.tryParse(place['longitude']),
                          });
                          Get.back();
                        },
                        leading: const Icon(Icons.location_on,
                            color: Colors.orange),
                        title: Text(
                          place['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                }

                // --- No results for search ---
                if (hasQuery && results.isEmpty) {
                  return const Center(
                    child: Text(
                      'No places found',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  );
                }

                // --- Show Recent Places (default view) ---
                if (recent.isNotEmpty) {
                  return ListView.builder(
                    itemCount: recent.length,
                    itemBuilder: (context, index) {
                      final place = recent[index];
                      return ListTile(
                        onTap: () {
                          homeController.selectDestination(result: {
                            'name': place['name'],
                            'lat': double.tryParse(place['latitude']),
                            'long': double.tryParse(place['longitude']),
                          });
                          Get.back();
                        },
                        leading:
                        const Icon(Icons.history, color: Colors.grey),
                        title: Text(
                          place['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                }

                // --- When no search and no recent ---
                return const Center(
                  child: Text(
                    'Type to search for a destination',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
