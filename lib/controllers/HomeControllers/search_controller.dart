import 'package:get/get.dart';

class PlaceSearchController extends GetxController {
  // Yeh search bar mein likhi hui text ko manage karega
  final RxString searchQuery = ''.obs;

  // Recent places ki list
  final RxList<Map<String, String>> recentPlaces = RxList([
    {'name': 'Office', 'address': 'Amar Business Zone, Pune', 'distance': '2.7 Km'},
    {'name': 'Coffee Shop', 'address': 'Amar Business Zone, Pune', 'distance': '1.1 Km'},
    {'name': 'Shopping Center', 'address': 'Amar Business Zone, Pune', 'distance': '4.1 Km'},
    {'name': 'Shopping Mall', 'address': 'Amar Business Zone, Pune', 'distance': '4.1 Km'},
  ]);

  // Search query ko update karne ka method
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Recent places list ko clear karne ka method
  void clearRecentPlaces() {
    recentPlaces.clear();
  }
}