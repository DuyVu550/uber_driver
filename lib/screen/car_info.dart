import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../global/global.dart';
import '../splashScreen/SplashScreen.dart';
import 'forgot_password_screen.dart';
import 'login_screen.dart';
class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  final carModelTextEditingController = TextEditingController();
  final carNumberTextEditingController = TextEditingController();
  final carColorTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _submit(){
    if(_formKey.currentState!.validate()){
      Map driverCarInfoMap = {
        "car_model": carModelTextEditingController.text.trim(),
        "car_number": carNumberTextEditingController.text.trim(),
        "car_color": carColorTextEditingController.text.trim(),
      };
      DatabaseReference userRef = FirebaseDatabase.instance.ref().child("drivers");
      userRef.child(currentUser!.uid).child("car_details").set(driverCarInfoMap);

      Fluttertoast.showToast(msg: "Car details added successfully");
      Navigator.push(context, MaterialPageRoute(builder: (c) => SplashScreen()));

    }
  }

  List<String> carTypes = [
    "Sedan",
    "SUV",
    "Truck",
    "Van",
    "Coupe",
    "Convertible",
    "Hatchback",
  ];
  String? selectedCarType;
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus(); // Dismiss the keyboard when tapping outside
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            Column(
              children: [
                Image.asset(darkTheme ? 'image/city_night.jpg' : 'image/city.jpg',),
                SizedBox(height: 20),
                Text(
                  "Add Car Details",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: "Car Model",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor:
                                darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color:
                                  darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.grey,
                                ),
                              ),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Name cannot be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid name";
                                }
                                if (text.length > 49) {
                                  return "Name cannot be more than 50 characters";
                                }
                              },
                              onChanged: (text) {
                                setState(() {
                                  carModelTextEditingController.text = text;
                                });
                              },
                            ),
                            SizedBox(height: 20),

                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: "Car Number",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor:
                                darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color:
                                  darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.grey,
                                ),
                              ),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Name cannot be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid name";
                                }
                                if (text.length > 49) {
                                  return "Name cannot be more than 50 characters";
                                }
                              },
                              onChanged: (text) {
                                setState(() {
                                  carNumberTextEditingController.text = text;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: "Car Color",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor:
                                darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color:
                                  darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.grey,
                                ),
                              ),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Name cannot be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid name";
                                }
                                if (text.length > 49) {
                                  return "Name cannot be more than 50 characters";
                                }
                              },
                              onChanged: (text) {
                                setState(() {
                                  carColorTextEditingController.text = text;
                                });
                              },
                            ),
                            SizedBox(height: 20),

                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "Please select car type",
                                prefixIcon: Icon(Icons.car_crash, color: darkTheme ? Colors.amber.shade400 : Colors.grey,),
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                              items: carTypes.map((car){
                                return DropdownMenuItem(
                                  child: Text(
                                    car,
                                    style: TextStyle(
                                      color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                                    ),
                                  ),
                                  value: car,
                                );
                              }).toList(),
                              onChanged: (newValue){
                                setState(() {
                                  selectedCarType = newValue.toString();
                                });
                              },
                            ),
                            SizedBox(height: 20),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                _submit();
                              },
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => ForgotPasswordScreen()),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color:
                                  darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 1),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color:
                                  darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
