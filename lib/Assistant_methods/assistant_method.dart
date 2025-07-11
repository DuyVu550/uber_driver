import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_driver/Assistant_methods/request_assistant.dart';

import '../InfoHandler/app_info.dart';
import '../Models/directions.dart';
import '../Models/directions_details_info.dart';
import '../Models/user_model.dart';
import '../global/Map.dart';
import '../global/global.dart';

class AssistantMethod {
  static void readCurrentOnlineUserInfo() async {
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentUser!.uid);
    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<String> searchAddressForGeographicCoordinates(Position position,
      context) async {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress = "";
    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
    if (requestResponse != "Error Occurred") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];
      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude.toString();
      userPickUpAddress.locationLongtitude = position.longitude.toString();
      userPickUpAddress.locationName = humanReadableAddress;
      Provider.of<AppInfo>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }
    return humanReadableAddress;
  }
  static Future<DirectionsDetailsInfo> obtainOriginToDestinationDirectionsDetails(LatLng originPosition, LatLng destinationPosition) async{
    String urlOriginToDestinationDirectionsDetails = "http://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";
    var responseDirectionsApi = await RequestAssistant.receiveRequest(urlOriginToDestinationDirectionsDetails);
    DirectionsDetailsInfo directionsDetailsInfo = DirectionsDetailsInfo();
    directionsDetailsInfo.e_points = responseDirectionsApi["routes"][0]["overview_polyline"]["points"];
    directionsDetailsInfo.distance_text = responseDirectionsApi["routes"][0]["legs"][0]["distance"]["text"];
    directionsDetailsInfo.distance_value = responseDirectionsApi["routes"][0]["legs"][0]["distance"]["value"];
    directionsDetailsInfo.duration_text = responseDirectionsApi["routes"][0]["legs"][0]["duration"]["text"];
    directionsDetailsInfo.duration_value = responseDirectionsApi["routes"][0]["legs"][0]["duration"]["value"];
    return directionsDetailsInfo;
  }
}
