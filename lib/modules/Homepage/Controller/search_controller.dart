import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/Constants/api_constants.dart';

class PlaceSearchController extends GetxController {
  /// Search query entered by user
  final RxString searchQuery = ''.obs;

  /// API search results
  final RxList<Map<String, dynamic>> searchResults =
      <Map<String, dynamic>>[].obs;

  /// Loader state
  final RxBool isLoading = false.obs;

  /// Recent places list
  final RxList<Map<String, dynamic>> recentPlaces =
      <Map<String, dynamic>>[].obs;

  final _storage = GetStorage();
  final String _storageKey = 'recent_places';

  @override
  void onInit() {
    super.onInit();
    _loadRecentPlaces();
  }

  /// Load recent places from storage
  void _loadRecentPlaces() {
    final List? stored = _storage.read(_storageKey);
    if (stored != null) {
      recentPlaces.value = List<Map<String, dynamic>>.from(stored);
    }
  }

  /// Save a place to recent list
  void addToRecent(Map<String, dynamic> place) {
    // Remove duplicates by name
    recentPlaces.removeWhere((p) => p['name'] == place['name']);
    // Add to top
    recentPlaces.insert(0, place);

    // Limit to last 5 items
    if (recentPlaces.length > 10) {
      recentPlaces.removeLast();
    }

    _storage.write(_storageKey, recentPlaces);
  }

  /// Clear all recent places
  void clearRecentPlaces() {
    recentPlaces.clear();
    _storage.remove(_storageKey);
  }

  /// Update query and trigger API
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      fetchPlaces(query);
    } else {
      searchResults.clear();
    }
  }

  /// Fetch places from API
  Future<void> fetchPlaces(String query) async {
    try {
      isLoading.value = true;
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.destinationEndpoint}$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        searchResults.value = data.map((place) {
          return {
            'name': place['name'],
            'latitude': place['latitude'],
            'longitude': place['longitude'],
          };
        }).toList();
      } else {
        searchResults.clear();
      }
    } catch (e) {
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
