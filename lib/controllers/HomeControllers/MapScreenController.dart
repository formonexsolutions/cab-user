import 'dart:async';
import 'dart:ui' as ui; // dart:ui import करें
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// यह GetX Controller आपके ऐप के सभी logic और state को manage करेगा।
class AppController extends GetxController {
  // reactive variables जो UI को automatically अपडेट करते हैं।
  Rx<LatLng> carPosition = const LatLng(18.5539, 73.9476).obs;
  Rx<LatLng> destinationPosition = const LatLng(18.1705, 73.6625).obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxBool isLoading = true.obs; // Loading state के लिए reactive variable

  // Car icon को null से बचाने के लिए एक डिफ़ॉल्ट मान दें
  late BitmapDescriptor carIcon;

  // Pickup और destination के लिए Text Controller
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  // Controller initialize होने पर call होता है
  @override
  void onInit() {
    super.onInit();
    _loadAssets();
    // यहाँ आप WebSocket connection भी शुरू कर सकते हैं।
  }

  // Icons और अन्य assets लोड करने का फंक्शन
  Future<void> _loadAssets() async {
    try {
      // getResizedMarkerIcon का उपयोग करके image को लोड करें और resize करें
      carIcon = await getResizedMarkerIcon('assets/images/carIconMap.png', 150);

      // Icons लोड होने के बाद Markers को अपडेट करें
      _updateMarkers();
    } catch (e) {
      debugPrint('Error loading assets: $e');
      carIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      _updateMarkers();
    } finally {
      // Assets लोड होने के बाद isLoading को false करें
      isLoading.value = false;
    }
  }

  // Markers को अपडेट करने का फंक्शन
  void _updateMarkers() {
    markers.clear();
    // कार का मार्कर
    markers.add(
      Marker(
        markerId: const MarkerId('car'),
        position: carPosition.value,
        icon: carIcon,
      ),
    );
    // डेस्टिनेशन का मार्कर
    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: destinationPosition.value,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  // car की location को update करने का demo फंक्शन
  void moveCar() {
    // यहाँ आप Node.js से live data receive करके carPosition को अपडेट कर सकते हैं।
    // demo के लिए, हम destination पर car को move कर रहे हैं।
    carPosition.value = destinationPosition.value;
    _updateMarkers();
  }

  @override
  void onClose() {
    pickupController.dispose();
    destinationController.dispose();
    super.onClose();
  }

  // यह फंक्शन image को resize करके BitmapDescriptor return करता है
  Future<BitmapDescriptor> getResizedMarkerIcon(String imagePath, double targetWidth) async {
    final ByteData data = await rootBundle.load(imagePath);
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: targetWidth.round());
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;
    final ByteData? resizedData = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(resizedData!.buffer.asUint8List());
  }
}