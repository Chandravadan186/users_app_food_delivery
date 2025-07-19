import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/global_instances.dart';
import 'package:users_app/provider/cart_item_counter.dart';
import '../global/global_vars.dart';


class CartViewModel
{
  separateItemIDs()
  {
    List<String> separateItemIDsList=[], defaultItemList=[];
    int i=0;

    defaultItemList = sharedPreferences!.getStringList("userCart")!;

    for(i; i<defaultItemList.length; i++)
    {
      //56557657:7
      String item = defaultItemList[i].toString();
      print("\nThis is itemID : quantityNumber = " + item);
      var pos = item.lastIndexOf(":"); //56557657:7

      //56557657
      String getItemId = (pos != -1) ? item.substring(0, pos) : item;

      print("\nThis is itemID now = " + getItemId);

      separateItemIDsList.add(getItemId);
    }

    print("\nThis is Items List now = ");
    print(separateItemIDsList);
    return separateItemIDsList;
  }

  addItemToCart(String? itemId, BuildContext context, int quantityNumber)
  {
    List<String>? tempList = sharedPreferences!.getStringList("userCart");
    tempList!.add(itemId! + ":" + quantityNumber.toString());  //56557657:4

    FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
        {
          "userCart": tempList,
        }).then((value)
    {
      sharedPreferences!.setStringList("userCart", tempList);
      
      commonViewModel.showSnackBar("Item Added Successfully to Cart.", context);

      //update the badge
      Provider.of<CartItemCounter>(context, listen: false).showCartListItemsNumber();
    });
  }

  getCartItems()
  {
    return FirebaseFirestore.instance
        .collection("items")
        .where("itemID", whereIn: separateItemIDs())
        .orderBy("publishedDateTime", descending: true)
        .snapshots();
  }

  separateItemQuantities()
  {
    List<int> separateItemQuantityList=[];
    List<String> defaultItemList=[];
    int i=1;

    defaultItemList = sharedPreferences!.getStringList("userCart")!;

    for(i; i<defaultItemList.length; i++)
    {
      //56557657:7
      //56557467:5
      String item = defaultItemList[i].toString();

      //:7
      //0 = : //1 = 7
      List<String> listItemCharacters = item.split(":").toList();

      var quanNumber = int.parse(listItemCharacters[1].toString());

      separateItemQuantityList.add(quanNumber);
    }

    return separateItemQuantityList;
  }

  clearCartNow(BuildContext context) async
  {
    sharedPreferences!.setStringList("userCart", ['garbageValue']);
    List<String>? emptyList = sharedPreferences!.getStringList("userCart");

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
        {
          "userCart": emptyList,
        }).then((value)
    {
      sharedPreferences!.setStringList("userCart", emptyList!);
      Provider.of<CartItemCounter>(context, listen: false).showCartListItemsNumber();
    });
  }
}