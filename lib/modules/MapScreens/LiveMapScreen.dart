import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp के बजाय GetMaterialApp का उपयोग करें।
    return const GetMaterialApp(
      home: LiveMapScreen(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
