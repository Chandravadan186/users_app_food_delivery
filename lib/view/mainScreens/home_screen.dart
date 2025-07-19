<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/global/global_vars.dart';
import 'package:riders_app/view/mainScreens/earnings_screen.dart';
import 'package:riders_app/view/mainScreens/history_screen.dart';
import 'package:riders_app/view/mainScreens/new_available_orders_screen.dart';
import 'package:riders_app/view/mainScreens/not_yet_delivered_screen.dart';
import 'package:riders_app/view/mainScreens/parcels_in_progress_screen.dart';
import 'package:riders_app/view/splashScreen/splash_screen.dart';
=======
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/global/global_instances.dart';
import 'package:users_app/model/item.dart';
import 'package:users_app/model/seller.dart';
import 'package:users_app/view/widgets/item_ui_design.dart';
import 'package:users_app/view/widgets/my_appbar.dart';
import 'package:users_app/view/widgets/rp_item_ui_design.dart';
import 'package:users_app/view/widgets/seller_ui_design.dart';

import '../widgets/my_drawer.dart';
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
<<<<<<< HEAD
  Card dashboardItem(String title, IconData iconData, int index)
  {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                )
              )
            : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.black54],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                )
              ),
        child: InkWell(
          onTap: ()
          {
            if(index == 0)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> NewAvailableOrdersScreen()));
            }
            if(index == 1)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ParcelInProgressScreen()));
            }
            if(index == 2)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> NotYetDeliveredScreen()));
            }
            if(index == 3)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
            }
            if(index == 4)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> EarningScreen()));
            }
            if(index == 5)
            {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [

              const SizedBox(height: 50.0),

              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10.0),

              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
=======
  List bannerImagesList = [];
  List categoriesList = [];

  updateUI() async
  {
    bannerImagesList = await homeViewModel.readBannersFromFirestore();
    categoriesList = await homeViewModel.readCategoriesFromFirestore();

    setState(() {
      bannerImagesList;
      categoriesList;
    });

    cartViewModel.clearCartNow(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI();
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Welcome  ${sharedPreferences!.getString("name")}",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          children: [

            dashboardItem("New Available Orders", Icons.assignment, 0),
            dashboardItem("Parcels in Progress", Icons.airport_shuttle, 1),
            dashboardItem("Not Yet Delivered", Icons.location_history, 2),
            dashboardItem("History", Icons.done_all, 3),
            dashboardItem("Total Earnings", Icons.monetization_on, 4),
            dashboardItem("Logout", Icons.logout, 5),
            
=======
      drawer: MyDrawer(),
      appBar: MyAppBar(
        titleMsg: "iFood",
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //banners
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 10, right: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .3,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: bannerImagesList.map((index)
                  {
                    return Builder(
                      builder: (BuildContext context)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.network(
                              index,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 8,),

            //categories
            const Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categoriesList.map((index)
                {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(
                        index,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      selected: categoriesList.contains(index),
                      onSelected: (c)
                      {
                        //commonViewModel.showSnackBar(index, context);
                      },
                      backgroundColor: Colors.white30,
                    ),
                  );
                }).toList(),
              ),
            ),

            //recommended
            const Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recommended:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 264,
              child: StreamBuilder<QuerySnapshot>(
                stream: homeViewModel.readRecommendedItemsFromFirestore(),
                builder: (context, snapshot)
                {
                  return !snapshot.hasData
                      ? const Center(child: Text("no recommended items found"),)
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index)
                          {
                            Item itemModel = Item.fromJson(
                              snapshot.data!.docs[index].data() as Map<String, dynamic>
                            );

                            return Card(
                              elevation: 6,
                              child: RPItemUIDesign(
                                itemModel: itemModel,
                              ),
                            );
                          },
                        );
                },
              ),
            ),
            const SizedBox(height: 8,),

            //popular
            const Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 264,
              child: StreamBuilder<QuerySnapshot>(
                stream: homeViewModel.readPopularItemsFromFirestore(),
                builder: (context, snapshot)
                {
                  return !snapshot.hasData
                      ? const Center(child: Text("no popular items found"),)
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index)
                    {
                      Item itemModel = Item.fromJson(
                          snapshot.data!.docs[index].data() as Map<String, dynamic>
                      );

                      return Card(
                        elevation: 6,
                        child: RPItemUIDesign(
                          itemModel: itemModel,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8,),

            //sellers - cafes/restaurents
            const Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cafes & Restaurants:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 284,
              child: StreamBuilder<QuerySnapshot>(
                stream: homeViewModel.readSellersFromFirestore(),
                builder: (context, snapshot)
                {
                  return !snapshot.hasData
                      ? const Center(child: Text("no seller found"),)
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index)
                    {
                      Seller sellerModel = Seller.fromJson(
                          snapshot.data!.docs[index].data() as Map<String, dynamic>
                      );

                      return Card(
                        elevation: 6,
                        child: SellerUIDesign(
                          sellerModel: sellerModel,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
          ],
        ),
      ),
    );
  }
}
