// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

/// Yeh file Firestore se related sabhi operations ko handle karti hai.
/// Yeh ek foundation layer hai jo aapke app ke data ko Firestore mein store karegi.

// --- Data Models ---
// Yeh classes Firestore documents ke structure ko define karti hain.
// Aapko in classes ke instances banakar methods ko call karna hoga.

class UserModel {
  String uid;
  String? email;
  String? displayName;
  String? photoURL;
  String role;
  String status;
  GeoPoint? currentLocation;
  String? phoneNumber;
  String? vehicleId;
  Timestamp? createdAt;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    required this.role,
    this.status = 'offline',
    this.currentLocation,
    this.phoneNumber,
    this.vehicleId,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'role': role,
      'status': status,
      'currentLocation': currentLocation,
      'phoneNumber': phoneNumber,
      'vehicleId': vehicleId,
      'createdAt': createdAt,
    };
  }
}

class VehicleModel {
  String id;
  String driverId;
  String make;
  String model;
  String numberPlate;
  String type;
  String color;
  bool isVerified;

  VehicleModel({
    required this.id,
    required this.driverId,
    required this.make,
    required this.model,
    required this.numberPlate,
    required this.type,
    required this.color,
    this.isVerified = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverId': driverId,
      'make': make,
      'model': model,
      'numberPlate': numberPlate,
      'type': type,
      'color': color,
      'isVerified': isVerified,
    };
  }
}

class RideModel {
  String id;
  String riderId;
  String? driverId;
  String status;
  GeoPoint pickupLocation;
  GeoPoint destinationLocation;
  String pickupAddress;
  String destinationAddress;
  double price;
  Timestamp? startTime;
  Timestamp? endTime;

  RideModel({
    required this.id,
    required this.riderId,
    this.driverId,
    required this.status,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.price,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'riderId': riderId,
      'driverId': driverId,
      'status': status,
      'pickupLocation': pickupLocation,
      'destinationLocation': destinationLocation,
      'pickupAddress': pickupAddress,
      'destinationAddress': destinationAddress,
      'price': price,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}

class TransactionModel {
  String id;
  String rideId;
  String riderId;
  String driverId;
  double amount;
  double commission;
  String status;
  String type;
  Timestamp createdAt;

  TransactionModel({
    required this.id,
    required this.rideId,
    required this.riderId,
    required this.driverId,
    required this.amount,
    required this.commission,
    required this.status,
    required this.type,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rideId': rideId,
      'riderId': riderId,
      'driverId': driverId,
      'amount': amount,
      'commission': commission,
      'status': status,
      'type': type,
      'createdAt': createdAt,
    };
  }
}

class DriverDocumentModel {
  String id;
  String driverId;
  String documentType;
  String imageUrl;
  String verificationStatus;
  Timestamp uploadedAt;

  DriverDocumentModel({
    required this.id,
    required this.driverId,
    required this.documentType,
    required this.imageUrl,
    required this.verificationStatus,
    required this.uploadedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverId': driverId,
      'documentType': documentType,
      'imageUrl': imageUrl,
      'verificationStatus': verificationStatus,
      'uploadedAt': uploadedAt,
    };
  }
}

class AppSettingsModel {
  String id;
  double baseFare;
  double pricePerKm;
  double pricePerMinute;
  double driverCommissionRate;
  double surgeMultiplier;

  AppSettingsModel({
    required this.id,
    required this.baseFare,
    required this.pricePerKm,
    required this.pricePerMinute,
    required this.driverCommissionRate,
    required this.surgeMultiplier,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'baseFare': baseFare,
      'pricePerKm': pricePerKm,
      'pricePerMinute': pricePerMinute,
      'driverCommissionRate': driverCommissionRate,
      'surgeMultiplier': surgeMultiplier,
    };
  }
}

class RatingModel {
  String id;
  String fromUid;
  String toUid;
  String rideId;
  double rating;
  String? comment;
  Timestamp createdAt;

  RatingModel({
    required this.id,
    required this.fromUid,
    required this.toUid,
    required this.rideId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromUid': fromUid,
      'toUid': toUid,
      'rideId': rideId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }
}

class NotificationModel {
  String id;
  String toUid;
  String title;
  String body;
  bool isRead;
  Timestamp createdAt;

  NotificationModel({
    required this.id,
    required this.toUid,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'toUid': toUid,
      'title': title,
      'body': body,
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }
}

class PromotionModel {
  String id;
  String code;
  double discountAmount;
  Timestamp expiryDate;
  String? appliedByUid;

  PromotionModel({
    required this.id,
    required this.code,
    required this.discountAmount,
    required this.expiryDate,
    this.appliedByUid,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountAmount': discountAmount,
      'expiryDate': expiryDate,
      'appliedByUid': appliedByUid,
    };
  }
}

// --- Firestore Service Class ---
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestore mein naya user add karta hai.
  Future<void> createUser({required UserModel user}) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toJson(), SetOptions(merge: true));
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  /// Firestore mein naya vehicle add karta hai.
  Future<void> createVehicle({required VehicleModel vehicle}) async {
    try {
      await _firestore.collection('vehicles').doc(vehicle.id).set(vehicle.toJson());
    } catch (e) {
      print('Error creating vehicle: $e');
    }
  }

  /// Firestore mein naya ride record add karta hai.
  Future<void> createRide({required RideModel ride}) async {
    try {
      await _firestore.collection('rides').doc(ride.id).set(ride.toJson());
    } catch (e) {
      print('Error creating ride: $e');
    }
  }

  /// Firestore mein naya transaction record add karta hai.
  Future<void> createTransaction({required TransactionModel transaction}) async {
    try {
      await _firestore.collection('transactions').doc(transaction.id).set(transaction.toJson());
    } catch (e) {
      print('Error creating transaction: $e');
    }
  }

  /// Firestore mein driver documents ka record add karta hai.
  Future<void> createDriverDocument({required DriverDocumentModel document}) async {
    try {
      await _firestore.collection('driver_documents').doc(document.id).set(document.toJson());
    } catch (e) {
      print('Error creating driver document: $e');
    }
  }

  /// App settings ko Firestore mein update ya create karta hai.
  Future<void> setAppSettings({required AppSettingsModel settings}) async {
    try {
      // Isme hum ek fixed ID use kar rahe hain taaki hamesha ek hi document ho
      await _firestore.collection('settings').doc('app_config').set(settings.toJson());
    } catch (e) {
      print('Error setting app settings: $e');
    }
  }

  /// Firestore mein rating ka record add karta hai.
  Future<void> createRating({required RatingModel rating}) async {
    try {
      await _firestore.collection('ratings').doc(rating.id).set(rating.toJson());
    } catch (e) {
      print('Error creating rating: $e');
    }
  }

  /// Firestore mein notification ka record add karta hai.
  Future<void> createNotification({required NotificationModel notification}) async {
    try {
      await _firestore.collection('notifications').doc(notification.id).set(notification.toJson());
    } catch (e) {
      print('Error creating notification: $e');
    }
  }

  /// Firestore mein promotion ka record add karta hai.
  Future<void> createPromotion({required PromotionModel promotion}) async {
    try {
      await _firestore.collection('promotions').doc(promotion.id).set(promotion.toJson());
    } catch (e) {
      print('Error creating promotion: $e');
    }
  }
}
