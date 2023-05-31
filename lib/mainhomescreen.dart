// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_contacts/errorscreen.dart';
import 'package:flutter_contacts/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  // API CALL FOR CHECK OF REGION ACCESS

  Future<String> getIpAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.country.is'));

      final jsonResponse = json.decode(response.body);
      final ipAddress = jsonResponse['ip'];
      final country = jsonResponse['country'];
      // final country = "KSSA";
      print('$ipAddress');
      print('$country');

      if (response.statusCode == 200 && country == "PK" ||
          response.statusCode == 200 && country == "KSA") {
        Navigator.push(context as BuildContext,
            MaterialPageRoute(builder: ((context) => HomeScreen())));
      } else {
        Navigator.push(context as BuildContext,
            MaterialPageRoute(builder: ((context) => ErrorScreen())));
      }
      return ipAddress;
    } catch (e) {
      print('Error getting IP address: $e');
      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: ((context) => ErrorScreen())));
    }
    return 'N/A';
  }

  @override
  void initState() {
    super.initState();
    getIpAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 151, 158, 183),
              Color.fromARGB(255, 87, 123, 160),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
                width: 50.h,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 1.5,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'NexGen Contacts App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
