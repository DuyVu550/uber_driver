
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_driver/Assistant_methods/assistant_method.dart';
import 'package:uber_driver/Models/user_ride_request_information.dart';
import 'package:uber_driver/global/global.dart';
class NotificationDialogBox extends StatefulWidget {
  UserRideRequestInformation? userRideRequestDetails;

  NotificationDialogBox({this.userRideRequestDetails});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkTheme ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              onlineDriverData.car_type == "Car" ? "../image/car.png" : "../image/car.png",
            ),

            SizedBox(height: 10),

            Text("New Ride Request",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkTheme ? Colors.amber.shade400 : Colors.blue,
              ),
            ),

            SizedBox(height: 14),

            Divider(
              height: 2,
              thickness: 2,
              color: darkTheme ? Colors.amber.shade400 : Colors.blue,
            ),

            Padding(
                padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "../image/pick.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.userRideRequestDetails!.originAddress!,
                            style: TextStyle(
                              fontSize: 16,
                              color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Image.asset("../image/pick.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.userRideRequestDetails!.destinationAddress!,
                            style: TextStyle(
                              fontSize: 16,
                              color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: darkTheme ? Colors.amber.shade400 : Colors.blue,
            ),

            Padding(
                padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        audioPlayer?.pause();
                        audioPlayer?.stop();
                        audioPlayer = AssetsAudioPlayer();  
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        "Cancel".toUpperCase(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: (){
                        audioPlayer?.pause();
                        audioPlayer?.stop();
                        audioPlayer = AssetsAudioPlayer();
                        acceptRideRequest(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        "Accept".toUpperCase(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  acceptRideRequest(BuildContext context) {
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(firebaseAuth.currentUser!.uid)
        .child("newRideStatus")
        .once()
        .then((snapshot) {
      if (snapshot.snapshot.value == "idle") {
        FirebaseDatabase.instance.ref().child("drivers").child(
            firebaseAuth.currentUser!.uid).child("newRideStatus").set(
            "accepted");
        AssistantMethod.pauseLiveLocationUpdates();
      //  Navigator.push(context, MaterialPageRoute(builder: (c) => NewTripScreen()));
      }
      else{
        Fluttertoast.showToast(msg: "This ride request does not exist.");
      }
    });
  }
}
