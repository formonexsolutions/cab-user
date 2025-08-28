// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/HomeControllers/search_controller.dart';
//
// class SearchView extends GetView<PlaceSearchController> {
//   const SearchView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//       final PlaceSearchController controller = Get.find<PlaceSearchController>();
//
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // --- Top Search Bar ---
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.location_on, color: Colors.yellow, size: 24),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: TextField(
//                         onChanged: controller.updateSearchQuery,
//                         decoration: InputDecoration(
//                           hintText: 'Shivajinagar, Pune',
//                           border: InputBorder.none,
//                           // Yeh line add karein
//                           contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                           suffixIcon: Obx(() =>
//                           controller.searchQuery.value.isNotEmpty
//                               ? IconButton(
//                             icon: const Icon(Icons.close, color: Colors.grey),
//                             onPressed: () {
//                               controller.updateSearchQuery('');
//                               FocusScope.of(context).unfocus();
//                             },
//                           )
//                               : const SizedBox(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//
//             // --- Recent Places Section Header ---
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Recent Places',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: controller.clearRecentPlaces,
//                     child: const Text(
//                       'Clear All',
//                       style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, right: 15),
//               child: Divider(),
//             ),
//             // --- Recent Places List ---
//             Expanded(
//               child: Obx(
//                     () => ListView.builder(
//                   itemCount: controller.recentPlaces.length,
//                   itemBuilder: (context, index) {
//                     final place = controller.recentPlaces[index];
//                     return ListTile(
//                       onTap: () {
//                         // Yahan par changes karein
//                         // 'place['name']!' ko return karein aur back navigate karein
//                         Get.back(result: place['name']!);
//                       },
//                       leading: const Icon(Icons.access_time, color: Colors.grey),
//                       title: Text(
//                         place['name']!,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(place['address']!),
//                       trailing: Text(place['distance']!),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:car_travel/Utils/app_colors.dart';
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
            SizedBox(height: 20,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Reduced padding
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 12), // Reduced horizontal padding
            //     height: 40, // Set a specific height to make it smaller
            //     decoration: BoxDecoration(
            //       color: AppColors.backgroundFaintYellow,
            //       borderRadius: BorderRadius.circular(10), // Smaller radius
            //     ),
            //     child: Row(
            //       children: [
            //         const Icon(Icons.location_on, color: Colors.grey, size: 20), // Smaller icon
            //         const SizedBox(width: 8), // Reduced spacing
            //         Expanded(
            //           child: TextField(
            //             onChanged: controller.updateSearchQuery,
            //             decoration: InputDecoration(
            //               hintText: 'Shivajinagar, Pune',
            //               hintStyle: TextStyle(fontSize: 14), // Smaller hint text
            //               border: InputBorder.none,
            //               contentPadding: const EdgeInsets.symmetric(vertical: 8), // Reduced vertical padding
            //               isDense: true, // Makes the TextField more compact
            //               suffixIcon: Obx(() =>
            //               controller.searchQuery.value.isNotEmpty
            //                   ? IconButton(
            //                 icon: const Icon(Icons.close, color: Colors.grey, size: 18), // Smaller icon
            //                 onPressed: () {
            //                   controller.updateSearchQuery('');
            //                   FocusScope.of(context).unfocus();
            //                 },
            //               )
            //                   : const SizedBox(),
            //               ),
            //             ),
            //             style: TextStyle(fontSize: 14), // Smaller text input
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundFaintYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12), // left padding
                    const Icon(Icons.location_on, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),

                    // Text
                    Expanded(
                      child: Text(
                        "ABZ, Baner, Pune", // static location text
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Right cross icon
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        // TODO: apna action likho (clear / dismiss etc.)
                      },
                    ),
                    const SizedBox(width: 8), // right padding
                  ],
                ),
              ),
            ),


            // --- Recent Places Section Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0), // Reduced padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Places',
                    style: TextStyle(
                      fontSize: 16, // Reduced font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.clearRecentPlaces,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove default padding
                      minimumSize: Size(0, 0), // Make button smaller
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.buttonTextYellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 12, // Reduced font size
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12), // Reduced padding
              child: Divider(height: 1), // Smaller divider
            ),

            // --- Recent Places List ---
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.recentPlaces.length,
                  itemBuilder: (context, index) {
                    final place = controller.recentPlaces[index];
                    return ListTile(
                      dense: true, // Makes the ListTile more compact
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4), // Reduces vertical space
                      onTap: () {
                        Get.back(result: place['name']!);
                      },
                      leading: const Icon(Icons.access_time, color: Colors.black, size: 20), // Smaller icon
                      title: Text(
                        place['name']!,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14), // Reduced font size
                      ),
                      subtitle: Text(
                        place['address']!,
                        style: const TextStyle(fontSize: 12), // Reduced font size
                      ),
                      trailing: Text(
                        place['distance']!,
                        style: const TextStyle(fontSize: 12), // Reduced font size
                      ),
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