import 'package:flutter/material.dart';
// import 'package:flutter_application_1/view/container_view.dart';
import 'package:thrift_store/view/splashview/splashscreen.dart';
// import 'package:flutter_application_1/view/load_image_view.dart';
// Show login first

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Start with login
    );
  }
}
