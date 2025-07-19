<<<<<<< HEAD
=======
import 'package:flutter/cupertino.dart';
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:shared_preferences/shared_preferences.dart";

Position? position;
List<Placemark>? placeMark;
String fullAddress = "";
SharedPreferences? sharedPreferences;
<<<<<<< HEAD
String previousRiderEarnings = "";
String previousSellerEarnings = "";
String orderTotalAmount = "";
String amountChargedPerDelivery = "4";
=======
TextEditingController flatNumber = TextEditingController();
TextEditingController city = TextEditingController();
TextEditingController state = TextEditingController();
TextEditingController completeAddress = TextEditingController();
double latitudeValue = 0.0;
double longitudeValue = 0.0;
String paymentResult = "";
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
