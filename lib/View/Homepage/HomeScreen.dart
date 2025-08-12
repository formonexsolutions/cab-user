// // lib/views/home_view.dart
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//  import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../controllers/HomeControllers/HomeController.dart'; // Google Maps library for the map widget
//
// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // --- 1. Live Map View ---
//           // Ye GoogleMap widget live location aur markers dikhayega.
//           // Iske liye aapko 'google_maps_flutter' package add karna hoga.
//           Obx(() => controller.currentLocation.value == null
//               ? const Center(child: CircularProgressIndicator())
//               : GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: controller.currentLocation.value!,
//               zoom: 15,
//             ),
//             onMapCreated: controller.onMapCreated,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             markers: controller.markers,
//           ),
//           ),
//
//           // --- 2. Top App Bar with User Menu ---
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Menu Button
//                   InkWell(
//                     onTap: () {
//                       Get.snackbar('Menu', 'Menu button clicked!');
//                     },
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.menu, color: Colors.indigo),
//                     ),
//                   ),
//                   // User Profile/Avatar
//                   InkWell(
//                     onTap: () {
//                       Get.snackbar('Profile', 'Profile button clicked!');
//                     },
//                     child: CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         'https://placehold.co/100x100/png?text=User',
//                       ),
//                       backgroundColor: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // --- 3. Draggable Ride Request Bottom Panel ---
//           // Isse user bottom panel ko upar-neeche drag kar sakte hain.
//           DraggableScrollableSheet(
//             initialChildSize: 0.35, // Panel ki shuruati height
//             minChildSize: 0.1,    // Minimum height jab collapse ho
//             maxChildSize: 0.8,    // Maximum height jab expand ho
//             builder: (BuildContext context, ScrollController scrollController) {
//               return Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(0, -5),
//                     ),
//                   ],
//                 ),
//                 child: ListView(
//                   controller: scrollController,
//                   children: [
//                     Center(
//                       child: Container(
//                         height: 5,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // 'Where to?' Search Bar
//                     InkWell(
//                       onTap: () {
//                         // Jab user is par tap kare, to search screen par navigate karein.
//                         Get.toNamed('/search_destination');
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.search, color: Colors.grey),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Obx(() => Text(
//                                 controller.destination.value.isEmpty
//                                     ? 'Kahan jaana hai?'
//                                     : controller.destination.value,
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: controller.destination.value.isEmpty ? Colors.grey : Colors.black,
//                                 ),
//                               )),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Quick Destination Buttons (Home, Work)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildQuickDestinationButton(
//                           icon: Icons.home,
//                           label: 'Home',
//                           onTap: () => controller.selectDestination('Home'),
//                         ),
//                         _buildQuickDestinationButton(
//                           icon: Icons.work,
//                           label: 'Office',
//                           onTap: () => controller.selectDestination('Office'),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//
//                     const Divider(),
//
//                     const SizedBox(height: 20),
//
//                     // Vehicle Type Selection
//                     SizedBox(
//                       height: 100,
//                       child: Obx(
//                             () => ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             _buildVehicleType('Bike', Icons.motorcycle, controller.selectedVehicle.value == 'Bike'),
//                             _buildVehicleType('Auto', Icons.directions_bus, controller.selectedVehicle.value == 'Auto'),
//                             _buildVehicleType('Sedan', Icons.local_taxi, controller.selectedVehicle.value == 'Sedan'),
//                             _buildVehicleType('SUV', Icons.drive_eta, controller.selectedVehicle.value == 'SUV'),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // 'Request Ride' Button
//                     Obx(() => controller.isRequestingRide.value
//                         ? const Center(child: CircularProgressIndicator())
//                         : ElevatedButton(
//                       onPressed: () {
//                         controller.requestRide();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: const Text('Ride Request Karein', style: TextStyle(fontSize: 18)),
//                     ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuickDestinationButton({required IconData icon, required String label, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.indigo.withOpacity(0.1),
//             radius: 25,
//             child: Icon(icon, color: Colors.indigo),
//           ),
//           const SizedBox(height: 8),
//           Text(label, style: const TextStyle(fontSize: 14)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildVehicleType(String type, IconData icon, bool isSelected) {
//     return InkWell(
//       onTap: () => controller.selectVehicle(type),
//       child: Container(
//         width: 100,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.indigo : Colors.grey[100],
//           borderRadius: BorderRadius.circular(15),
//           border: isSelected ? Border.all(color: Colors.indigo, width: 2) : null,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 40,
//               color: isSelected ? Colors.white : Colors.indigo,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               type,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// lib/views/home_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Note: google_maps_flutter ko abhi use nahi kiya ja raha hai, isliye isse comment kar diya gaya hai.
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/HomeControllers/HomeController.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- 1. Dummy Map View ---
          // Google Map ki jagah ek dummy image dikha rahe hain.
          // Isse aapka UI flow bina API key ke bhi check kiya ja sakta hai.
          Container(
            color: Colors.grey[200], // Background color
            child: Center(
              child: Image.network(
                'https://gisgeography.com/wp-content/uploads/2022/04/High-Resolution-World-Map-scaled.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          // --- 2. Top App Bar with User Menu ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Menu Button
                  InkWell(
                    onTap: () {
                      Get.snackbar('Menu', 'Menu button clicked!');
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.menu, color: Colors.indigo),
                    ),
                  ),
                  // User Profile/Avatar
                  InkWell(
                    onTap: () {
                      Get.snackbar('Profile', 'Profile button clicked!');
                    },
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://placehold.co/100x100/png?text=User',
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 3. Draggable Ride Request Bottom Panel ---
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 'Where to?' Search Bar
                    InkWell(
                      onTap: () {
                        Get.toNamed('/search_destination');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Obx(() => Text(
                                controller.destination.value.isEmpty
                                    ? 'Where to?'
                                    : controller.destination.value,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: controller.destination.value.isEmpty ? Colors.grey : Colors.black,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Quick Destination Buttons (Home, Work)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickDestinationButton(
                          icon: Icons.home,
                          label: 'Home',
                          onTap: () => controller.selectDestination('Home'),
                        ),
                        _buildQuickDestinationButton(
                          icon: Icons.work,
                          label: 'Office',
                          onTap: () => controller.selectDestination('Office'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Divider(),

                    const SizedBox(height: 20),

                    // Vehicle Type Selection
                    SizedBox(
                      height: 100,
                      child: Obx(
                            () => ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildVehicleType('Bike', Icons.motorcycle, controller.selectedVehicle.value == 'Bike'),
                            _buildVehicleType('Auto', Icons.directions_bus, controller.selectedVehicle.value == 'Auto'),
                            _buildVehicleType('Sedan', Icons.local_taxi, controller.selectedVehicle.value == 'Sedan'),
                            _buildVehicleType('SUV', Icons.drive_eta, controller.selectedVehicle.value == 'SUV'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 'Request Ride' Button
                    Obx(() => controller.isRequestingRide.value
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: () {
                        controller.requestRide();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Ride Request Karein', style: TextStyle(fontSize: 18)),
                    ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickDestinationButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.indigo.withOpacity(0.1),
            radius: 25,
            child: Icon(icon, color: Colors.indigo),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildVehicleType(String type, IconData icon, bool isSelected) {
    return InkWell(
      onTap: () => controller.selectVehicle(type),
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: isSelected ? Border.all(color: Colors.indigo, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.white : Colors.indigo,
            ),
            const SizedBox(height: 8),
            Text(
              type,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
