// lib/pages/setup_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'Firestore_Service_Class.dart'; // Uuid library for unique IDs

/// Yeh page ek baar chalane ke liye banaya gaya hai.
/// Jab aap 'Create Sample Data' button par click karenge,
/// toh yeh Firestore mein sabhi collections mein dummy data daal dega.

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  // Sample data banane ka function
  Future<void> _createSampleData(BuildContext context) async {
    final firestoreService = FirestoreService();
    const uuid = Uuid();

    // -- Common UIDs --
    final riderUid = 'sampleRiderUid123';
    final driverUid = 'sampleDriverUid456';
    final rideId = 'sampleRideId001';
    final promoId = 'promoId001';

    // 1. Users collection mein rider aur driver ka data banayein
    final sampleRider = UserModel(
      uid: riderUid,
      email: 'rider@example.com',
      displayName: 'Aarav Kumar',
      photoURL: 'https://placehold.co/100x100/png?text=Rider',
      role: 'rider',
      createdAt: Timestamp.now(),
    );

    final sampleDriver = UserModel(
      uid: driverUid,
      email: 'driver@example.com',
      displayName: 'Vikram Singh',
      photoURL: 'https://placehold.co/100x100/png?text=Driver',
      role: 'driver',
      status: 'online',
      vehicleId: 'sampleVehicleId789',
      currentLocation: const GeoPoint(28.7041, 77.1025), // Delhi, India
      createdAt: Timestamp.now(),
    );

    await firestoreService.createUser(user: sampleRider);
    await firestoreService.createUser(user: sampleDriver);

    // 2. Vehicles collection mein gaadi ka data banayein
    final sampleVehicle = VehicleModel(
      id: 'sampleVehicleId789',
      driverId: driverUid,
      make: 'Maruti',
      model: 'Swift Dzire',
      numberPlate: 'DL-01-AB-1234',
      type: 'Sedan',
      color: 'White',
      isVerified: true,
    );
    await firestoreService.createVehicle(vehicle: sampleVehicle);

    // 3. Rides collection mein ek ride ka data banayein
    final sampleRide = RideModel(
      id: rideId,
      riderId: riderUid,
      driverId: driverUid,
      status: 'in_progress',
      pickupLocation: const GeoPoint(28.5355, 77.3910), // Noida
      destinationLocation: const GeoPoint(28.6139, 77.2090), // New Delhi
      pickupAddress: 'Sector 62, Noida',
      destinationAddress: 'Connaught Place, New Delhi',
      price: 450.50,
      startTime: Timestamp.now(),
    );
    await firestoreService.createRide(ride: sampleRide);

    // 4. App Settings collection mein default settings banayein
    final sampleSettings = AppSettingsModel(
      id: 'app_config',
      baseFare: 50.0,
      pricePerKm: 12.0,
      pricePerMinute: 1.5,
      driverCommissionRate: 20.0,
      surgeMultiplier: 1.2,
    );
    await firestoreService.setAppSettings(settings: sampleSettings);

    // --- New collections added below ---

    // 5. Ratings collection mein ek rating ka data banayein
    final sampleRating = RatingModel(
      id: uuid.v4(),
      fromUid: riderUid,
      toUid: driverUid,
      rideId: rideId,
      rating: 4.5,
      comment: 'Achhi ride thi, driver polite tha.',
      createdAt: Timestamp.now(),
    );
    await firestoreService.createRating(rating: sampleRating);

    // 6. Notifications collection mein ek notification ka data banayein
    final sampleNotification = NotificationModel(
      id: uuid.v4(),
      toUid: riderUid,
      title: 'Ride Complete!',
      body: 'Aapki ride Safar-e-Delhi successfully complete ho gayi hai.',
      isRead: false,
      createdAt: Timestamp.now(),
    );
    await firestoreService.createNotification(notification: sampleNotification);

    // 7. Promotions collection mein ek promotion ka data banayein
    final samplePromotion = PromotionModel(
      id: promoId,
      code: 'NEWUSER20',
      discountAmount: 20.0,
      expiryDate: Timestamp.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 86400000 * 30, // 30 days
      ),
      appliedByUid: null,
    );
    await firestoreService.createPromotion(promotion: samplePromotion);

    // Ek message dikhayein jab sabhi data create ho jaye
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sabhi collections mein sample data create ho gaya hai!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Setup'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Niche diye gaye button par click karke Firestore mein sabhi collections aur dummy data banayein.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _createSampleData(context),
                child: const Text(
                  'Create Sample Data',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
