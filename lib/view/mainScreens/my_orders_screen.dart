import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/global/global_instances.dart';
import 'package:users_app/view/widgets/my_appbar.dart';
import 'package:users_app/view/widgets/order_card_ui_design.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}



class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "My Orders", showBackButton: true,),
      body: StreamBuilder<QuerySnapshot>(
        stream: orderViewModel.retrieveOrders(),
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
