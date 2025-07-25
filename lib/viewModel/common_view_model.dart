import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../global/global_vars.dart';

class CommonViewModel
{
  getCurrentLocation() async
  {
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    position = cPosition;

<<<<<<< HEAD
=======
    latitudeValue = cPosition.latitude;
    longitudeValue = cPosition.longitude;

>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
    placeMark = await placemarkFromCoordinates(cPosition.latitude, cPosition.longitude);

    Placemark placeMarkVar = placeMark![0];

    fullAddress = "${placeMarkVar.subThoroughfare} ${placeMarkVar.thoroughfare}, ${placeMarkVar.subLocality} ${placeMarkVar.locality}, ${placeMarkVar.subAdministrativeArea}, ${placeMarkVar.administrativeArea} ${placeMarkVar.postalCode}, ${placeMarkVar.country}";

<<<<<<< HEAD
=======
    flatNumber.text = '${placeMarkVar.subThoroughfare} ${placeMarkVar.thoroughfare}, ${placeMarkVar.subLocality} ${placeMarkVar.locality}';
    city.text = '${placeMarkVar.subAdministrativeArea}, ${placeMarkVar.administrativeArea} ${placeMarkVar.postalCode}';
    state.text = '${placeMarkVar.country}';
    completeAddress.text = fullAddress;

>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
    return fullAddress;
  }

  updateLocationInDatabase() async
  {
    String address = await getCurrentLocation();

    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
        {
          "address": address,
          "latitude": position!.latitude,
          "longitude": position!.longitude,
        });
  }

  showSnackBar(String message, BuildContext context)
  {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
<<<<<<< HEAD

  getRiderPreviousEarnings() async
  {
    await FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      previousRiderEarnings = "";
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }

  getSellerPreviousEarnings(String sellerID) async
  {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerID)
        .get()
        .then((snap)
    {
      previousSellerEarnings = "";
      previousSellerEarnings = snap.data()!["earnings"].toString();
    });
  }

  getOrderTotalAmount(String orderID) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderID)
        .get()
        .then((snap)
    {
      orderTotalAmount = "";
      orderTotalAmount = snap.data()!["totalAmount"].toString();
    });
  }
=======
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
}