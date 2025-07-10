import 'package:flutter/material.dart';
import 'package:uber_driver/lib/global/global.dart';

import '../splashScreen/SplashScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            firebaseAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c) => SplashScreen()),);
          },
          child: Text(
            "Sign Out",
          ),
        ),
      ),
    );
  }
}
