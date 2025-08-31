import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Routes/AppRoutes.dart';
import 'controllers/GlobalController/globalController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(GlobalController(),permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Travel',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Default Scaffold background color set to white
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          elevation: 0,
        ),
      ),
      // initialRoute: AppRoutes.homeMap, // Splash Screen
      initialRoute: AppRoutes.splashInitial, // Splash Screen
      getPages: AppPages.routes,
    );
  }
}
