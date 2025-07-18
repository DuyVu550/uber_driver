
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_driver/Models/user_ride_request_information.dart';
import 'package:uber_driver/global/global.dart';

import '../global/global.dart';
import 'notification_dialog_box.dart';

class PushNotificationSystem {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future initializeCloudMessaging(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        readUserRideRequestInformation(message.data["rideRequestId"], context);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      readUserRideRequestInformation(message.data["rideRequestId"], context);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      readUserRideRequestInformation(message.data["rideRequestId"], context);
    });
  }

  readUserRideRequestInformation(String userRideRequestId, BuildContext context) {
    FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .child(userRideRequestId)
        .child('driverId')
        .onValue.listen((event) {
          if(event.snapshot.value == "waiting" || event.snapshot.value == FirebaseAuth.instance.currentUser!.uid) {
            FirebaseDatabase.instance.ref().child("All Ride Requests")
              .child(userRideRequestId)
              .once()
              .then((snap) {
                if (snap.snapshot.value != null) {
                  audioPlayer?.open(Audio("music/music_notification.mp3"));
                  audioPlayer?.play();

                  double originLat = double.parse((snap.snapshot.value! as Map)["origin"]["latitude"]);
                  double originLng = double.parse((snap.snapshot.value! as Map)["origin"]["longitude"]);
                  String originAddress = (snap.snapshot.value! as Map)["originAddress"];

                  double destinationLat = double.parse((snap.snapshot.value! as Map)["destination"]["latitude"]);
                  double destinationLng = double.parse((snap.snapshot.value! as Map)["destination"]["longitude"]);
                  String destinationAddress = (snap.snapshot.value! as Map)["destinationAddress"];

                  String userName = (snap.snapshot.value! as Map)["userName"];
                  String userPhone = (snap.snapshot.value! as Map)["userPhone"];

                  String? rideRequestId = snap.snapshot.key;

                  UserRideRequestInformation userRideRequestDetails = UserRideRequestInformation();
                  userRideRequestDetails.originLatLng = LatLng(originLat, originLng);
                  userRideRequestDetails.originAddress = originAddress;
                  userRideRequestDetails.destinationLatLng = LatLng(destinationLat, destinationLng);
                  userRideRequestDetails.destinationAddress = destinationAddress;
                  userRideRequestDetails.userName = userName;
                  userRideRequestDetails.userPhone = userPhone;

                  userRideRequestDetails.rideRequestId = rideRequestId;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => NotificationDialogBox(
                        userRideRequestDetails: userRideRequestDetails,
                      )
                  );
                }
                else{
                  Fluttertoast.showToast(msg: "This Ride Request does not exist.");
                }
            });
          }
          else {
            Fluttertoast.showToast(msg: "This Ride Request has already been cancelled");
          }
      });
    }
    Future generateAndGetToken() async {
      String? registrationToken = await firebaseMessaging.getToken();
      print("FCM Token: $registrationToken");

      FirebaseDatabase.instance.ref().child("drivers").child(FirebaseAuth.instance.currentUser!.uid).child("token").set(registrationToken);

      FirebaseMessaging.instance.subscribeToTopic("allDrivers");
      FirebaseMessaging.instance.subscribeToTopic("allUsers");
    }
  }
