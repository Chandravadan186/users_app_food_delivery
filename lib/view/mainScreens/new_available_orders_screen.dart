import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../global/global_instances.dart';
import '../widgets/my_appbar.dart';
import '../widgets/order_card_ui_design.dart';


class NewAvailableOrdersScreen extends StatefulWidget {
  const NewAvailableOrdersScreen({super.key});

  @override
  State<NewAvailableOrdersScreen> createState() => _NewAvailableOrdersScreenState();
}



class _NewAvailableOrdersScreenState extends State<NewAvailableOrdersScreen> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "New Orders", showBackButton: true,),
      body: StreamBuilder<QuerySnapshot>(
        stream: orderViewModel.retrieveNewOrders(),
        builder: (c, snapshot)
        {
          return snapshot.hasData
              ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (c, index)
            {
              return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("items")
                    .where("itemID", whereIn: orderViewModel.separateItemIDsForOrder((snapshot.data!.docs[index].data() as Map<String, dynamic>)["productIDs"]))
                    .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                    .orderBy("publishedDateTime", descending: true)
                    .get(),
                builder: (c, snap)
                {
                  return snap.hasData
                      ? Card(
                    child: OrderCardUIDesign(
                      itemCount: snap.data!.docs.length,
                      data: snap.data!.docs,
                      orderID: snapshot.data!.docs[index].id,
                      seperateQuantitiesList: orderViewModel.separateItemQuantitiesForOrder((snapshot.data!.docs[index].data() as Map<String, dynamic>)["productIDs"]),),
                  )
                      : const Center(child: CircularProgressIndicator());
                },
              );
            },
          )
              : const Center(child: CircularProgressIndicator(color: Colors.red,),);
        },
      ),
    );
  }
}
