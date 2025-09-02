import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:ui' as ui; // dart:ui import करें
import 'package:flutter/services.dart';

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


class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller को instantiate करें
    final AppController controller = Get.put(AppController());

    return Scaffold(
      body: Obx(
            () => Stack(
          children: [
            // Google Map Widget
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator())
            else
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.carPosition.value,
                  zoom: 12.0,
                ),
                markers: controller.markers.value,
                myLocationEnabled: true,
              ),

            // Search Box और Buttons
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.pickupController,
                      decoration: InputDecoration(
                        hintText: 'Pickup Location',
                        prefixIcon: const Icon(Icons.location_pin, color: Colors.orange),
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    TextField(
                      controller: controller.destinationController,
                      decoration: InputDecoration(
                        hintText: 'Where to?',
                        prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 'Confirm Ride' Button
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  controller.moveCar(); // Demo के लिए car को move करें
                  Get.snackbar(
                    'Ride Confirmed',
                    'Your ride is on its way!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Confirm Ride',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// यह एक dummy URL है। आपको यहाँ अपने Node.js WebSocket server का URL देना होगा।
const String _webSocketUrl = 'ws://your-nodejs-backend.com:3000';

// यह आपका GetxController है जो सभी logic और state को manage करेगा।
class CarLocationController extends GetxController {
  // reactive variables बनाएँ, जो UI को automatically अपडेट करेंगे।
  final Rx<LatLng> carPosition = const LatLng(18.5539, 73.9476).obs;
  final RxSet<Marker> markers = <Marker>{}.obs;

  late WebSocketChannel _channel;
  late BitmapDescriptor carIcon;

  // यह onInit() function StatefulWidget के initState() जैसा है।
  @override
  void onInit() {
    super.onInit();
    _loadCarIcon();
    _connectWebSocket(); // WebSocket connection शुरू करें
  }

  // WebSocket से कनेक्ट करने का फंक्शन
  void _connectWebSocket() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_webSocketUrl));
      // incoming messages को listen करें
      _channel.stream.listen(
            (data) {
          // जब भी नया data आता है, उसे JSON से decode करें
          final Map<String, dynamic> locationData = jsonDecode(data);
          final double newLat = locationData['latitude'];
          final double newLng = locationData['longitude'];

          // Rx variable को अपडेट करें। GetX automatically UI को अपडेट कर देगा।
          carPosition.value = LatLng(newLat, newLng);
          _updateCarMarker();
        },
        onError: (error) {
          debugPrint('WebSocket Error: $error');
          // Error होने पर connection को handle करें
        },
        onDone: () {
          debugPrint('WebSocket connection closed.');
          // Connection बंद होने पर reconnection logic implement करें
        },
      );
    } catch (e) {
      debugPrint('Failed to connect to WebSocket: $e');
    }
  }

  // कस्टम कार आइकन को लोड करने का फंक्शन
  Future<void> _loadCarIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/car_icon.png',
    );
    carIcon = icon;
    _updateCarMarker();
  }

  // कार के मार्कर को अपडेट करने का फंक्शन
  void _updateCarMarker() {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('car'),
        position: carPosition.value,
        icon: carIcon,
      ),
    );
  }

  // यह onClose() function StatefulWidget के dispose() जैसा है।
  @override
  void onClose() {
    _channel.sink.close(); // जब controller dispose हो तो connection बंद करें
    super.onClose();
  }
}

// यह आपका StatelessWidget है जो controller से data लेता है।
class LiveMapScreen extends StatelessWidget {
  const LiveMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX Controller को instantiate करें।
    final CarLocationController controller = Get.put(CarLocationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location Tracking with GetX'),
        backgroundColor: Colors.blueAccent,
      ),
      // Obx() का उपयोग reactive variables के changes को listen करने के लिए होता है।
      body: Obx(
            () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: controller.carPosition.value,
            zoom: 12.0,
          ),
          markers: controller.markers.value,
          onMapCreated: (GoogleMapController googleMapController) {
            // map controller को handle करने के लिए आप इसे GetxController में भी रख सकते हैं।
          },
        ),
      ),
    );
  }
}


