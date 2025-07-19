import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/model/address.dart';
import 'package:riders_app/view/mainScreens/parcel_delivering_screen.dart';
import 'package:riders_app/view/mainScreens/parcel_picking_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../global/global_vars.dart';



class OrderViewModel
{

  saveOrderDetailsToDatabase(addressID, totalAmount, sellerUID, orderId)
  {
    writeOrderDetailsForUser({
      "addressID": addressID,
      "totalAmount": totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Online Payment",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    });

    writeOrderDetailsForSeller(({
      "addressID": addressID,
      "totalAmount": totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Online Payment",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    }));
  }

  writeOrderDetailsForUser(Map<String, dynamic> dataMap) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(dataMap["orderId"])
        .set(dataMap);
  }

  writeOrderDetailsForSeller(Map<String, dynamic> dataMap) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(dataMap["orderId"])
        .set(dataMap);
  }

  retrieveNewOrders()
  {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "normal")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }

  retrieveOrdersPicked()
  {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("riderUID", isEqualTo: sharedPreferences!.getString("uid"))
        .where("status", isEqualTo: "picking")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }

  retrieveOrdersNotYetDelivered()
  {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("riderUID", isEqualTo: sharedPreferences!.getString("uid"))
        .where("status", isEqualTo: "delivering")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }

  retrieveOrdersHistory()
  {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("riderUID", isEqualTo: sharedPreferences!.getString("uid"))
        .where("status", isEqualTo: "ended")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }

  separateItemIDsForOrder(orderIDs)
  {
    List<String> separateItemIDsList=[], defaultItemList=[];
    int i=0;

    defaultItemList = List<String>.from(orderIDs);

    for(i; i<defaultItemList.length; i++)
    {
      //56557657:7
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      //56557657
      String getItemId = (pos != -1) ? item.substring(0, pos) : item;

      separateItemIDsList.add(getItemId);
    }

    return separateItemIDsList;
  }

  separateItemQuantitiesForOrder(orderIDs)
  {
    List<String> separateItemQuantityList=[];
    List<String> defaultItemList=[];
    int i=1;

    defaultItemList = List<String>.from(orderIDs);

    for(i; i<defaultItemList.length; i++)
    {
      //56557657:7
      String item = defaultItemList[i].toString();


      //0=:
      //1=7
      //:7
      List<String> listItemCharacters = item.split(":").toList();

      //7
      var quanNumber = int.parse(listItemCharacters[1].toString());

      separateItemQuantityList.add(quanNumber.toString());
    }

    return separateItemQuantityList;
  }

  getSpecificOrder(String orderID)
  {
    return FirebaseFirestore.instance
        .collection("orders")
        .doc(orderID)
        .get();
  }

  getShipmentAddress(String addressID, String orderByUserID)
  {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(orderByUserID)
        .collection("userAddress")
        .doc(addressID)
        .get();
  }

  confirmToDeliverParcel(orderId, sellerId, orderByUser, completeAddress, context, Address model) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .update(
    {
      "riderUID": sharedPreferences!.getString("uid"),
      "riderName": sharedPreferences!.getString("name"),
      "status": "picking",
      "lat": position!.latitude,
      "lng": position!.longitude,
      "address": completeAddress,
    }).then((value)
    {
      //send rider to parcel picking screen
      Navigator.push(context, MaterialPageRoute(builder: (c)=> ParcelPickingScreen(
        purchaserId: orderByUser,
        purchaserAddress: model.fullAddress,
        purchaserLat: model.lat,
        purchaserLng: model.lng,
        sellerId: sellerId,
        getOrderID: orderId,
      )));
    });
  }

  confirmParcelHasBeenPicked(getOrderId, sellerId, purchaserId, purchaserAddress, purchaserLat, purchaserLng, completeAddress, context) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId)
        .update(
        {
          "status": "delivering",
          "address": completeAddress,
          "lat": position!.latitude,
          "lng": position!.longitude,
        });

    //send rider to parcel delivering screen
    Navigator.push(context, MaterialPageRoute(builder: (c)=> ParcelDeliveringScreen(
      purchaserId: purchaserId,
      purchaserAddress: purchaserAddress,
      purchaserLat: purchaserLat,
      purchaserLng: purchaserLng,
      sellerId: sellerId,
      getOrderID: getOrderId,
    )));
  }

  confirmParcelHasBeenDelivered(getOrderId, sellerId, purchaserId, purchaserAddress, purchaserLat, purchaserLng, completeAddress) async
  {
    String totalEarningOfRider = ((double.parse(previousRiderEarnings)) + (double.parse(amountChargedPerDelivery))).toString();
    String totalEarningOfSeller = ((double.parse(previousSellerEarnings)) + (double.parse(orderTotalAmount))).toString();

    await FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId)
        .update(
        {
          "status": "ended",
          "address": completeAddress,
          "lat": position!.latitude,
          "lng": position!.longitude,
          "deliveryAmount": amountChargedPerDelivery,
        }).then((value) async
    {
      await FirebaseFirestore.instance
          .collection("riders")
          .doc(sharedPreferences!.getString("uid"))
          .update(
          {
            "earnings": totalEarningOfRider,
          }).then((value) async
      {
        await FirebaseFirestore.instance
            .collection("sellers")
            .doc(sellerId).update(
            {
              "earnings": totalEarningOfSeller,
            }).then((value) async
        {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(purchaserId)
              .collection("orders")
              .doc(getOrderId).update(
              {
                "status": "ended",
                "riderUID": sharedPreferences!.getString("uid"),
              });
        });
      });
    });
  }

  lauchMapFromSourceToDestination(sourceLat, sourceLng, destinationLat, destinationLng) async
  {
    String mapOptions =
    [
      'saddr=$sourceLat,$sourceLng',
      'daddr=$destinationLat,$destinationLng',
      'dir_action=navigate'
    ].join('&');

    final googleMapUrl = 'https://www.google.com/maps?$mapOptions';

    if(await launchUrl(Uri.parse(googleMapUrl)))
    {
      await launchUrl(Uri.parse(googleMapUrl));
    }
    else
    {
      throw "Could not open the google map.";
    }
  }
}