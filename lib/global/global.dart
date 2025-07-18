import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_driver/Models/driver_data.dart';


import '../Models/directions_details_info.dart';
import '../Models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;
StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionDriverLivePosition;
AssetsAudioPlayer? audioPlayer = AssetsAudioPlayer();
UserModel? userModelCurrentInfo;
Position? driverCurrentPosition;
DirectionsDetailsInfo? tripDirectionsDetailsInfo;
DriverData onlineDriverData = DriverData();
String? driverVehicleType = "";