import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:users_app/global/global_instances.dart';
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

  retrieveOrders()
  {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .where("status", isEqualTo: "normal")
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
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderID)
        .get();
  }

  getShipmentAddress(String addressID)
  {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("userAddress")
        .doc(addressID)
        .get();
  }

  retrieveOrdersHistory()
  {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .where("status", isEqualTo: "ended")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }
}