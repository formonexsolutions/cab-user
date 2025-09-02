import 'package:get/get.dart';

class Ride {
  final String date;
  final String pickupAddress;
  final String dropoffAddress;
  final String time;
  final double rating;
  final double price;

  Ride({
    required this.date,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.time,
    required this.rating,
    required this.price,
  });
}

class AllRidesController extends GetxController {
  // Observable list of rides
  var allRides = <Ride>[].obs;
  var completedRides = <Ride>[].obs;
  var canceledRides = <Ride>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate fetching data
    _fetchRides();
  }

  void _fetchRides() {
    // Mock data for demonstration
    allRides.assignAll([
      Ride(
        date: 'Today, Feb 15',
        pickupAddress: '123 Main Street, Downtown',
        dropoffAddress: '456 Park Avenue, Uptown',
        time: '25 min',
        rating: 4.8,
        price: 12.50,
      ),
      Ride(
        date: 'Yesterday, Feb 14',
        pickupAddress: '789 Oak Road, Westside',
        dropoffAddress: '321 Pine Street, Eastside',
        time: '35 min',
        rating: 4.5,
        price: 15.75,
      ),
      Ride(
        date: 'Yesterday, Feb 14',
        pickupAddress: '789 Oak Road, Westside',
        dropoffAddress: '321 Pine Street, Eastside',
        time: '35 min',
        rating: 4.5,
        price: 15.75,
      ),
      // Add more mock data as needed
    ]);

    // For simplicity, let's just copy allRides to completedRides and canceledRides
    // In a real app, you would filter based on ride status
    completedRides.assignAll(allRides.where((ride) => ride.rating > 4.0).toList());
    canceledRides.assignAll(allRides.where((ride) => ride.rating < 4.0).toList()); // Example: assuming low rating means canceled
  }

}