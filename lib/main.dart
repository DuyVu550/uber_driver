import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_driver/lib/screen/car_info.dart';
import 'package:uber_driver/lib/splashScreen/SplashScreen.dart';
import 'package:uber_driver/lib/themeProvider/themeProvider.dart';

import 'lib/InfoHandler/app_info.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Firebase.apps.isEmpty){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBvgpaJ16-Kq9T-XFkDmcl9-zKCnhF-tCU",
        appId: "1:168114649559:android:11b9faf55633751d0ff392",
        messagingSenderId: "168114649559",
        databaseURL: "https://trippo-73fd7-default-rtdb.firebaseio.com",
        projectId: "trippo-73fd7",
      ),
   );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppInfo(),
      child: MaterialApp(
        title: 'Uber Clone',
        debugShowCheckedModeBanner: false,
       // themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}


