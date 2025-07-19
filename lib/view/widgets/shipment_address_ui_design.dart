import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:riders_app/global/global_instances.dart';
import '../../model/address.dart';
import '../splashScreen/splash_screen.dart';
=======
import 'package:users_app/model/address.dart';
import 'package:users_app/view/splashScreen/splash_screen.dart';
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a

class ShipmentAddressUIDesign extends StatelessWidget
{
  Address? model;
<<<<<<< HEAD
  String? orderStatus;
  String? orderId;
  String? sellerId;
  String? orderByUser;

  ShipmentAddressUIDesign({super.key, this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});
=======

  ShipmentAddressUIDesign({super.key, this.model,});
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'Shipping Details:',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
          ),
        ),

        const SizedBox(
          height: 6.0,
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [

              TableRow(
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(model!.name!),
                ],
              ),

              TableRow(
                children: [
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(model!.phoneNumber!),
                ],
              ),

            ],
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),

<<<<<<< HEAD

        orderStatus == "ended"
            ? Container() : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () async
              {
                //rider location updated
                String completeAddress = await commonViewModel.getCurrentLocation();

                //confirm to deliver
                orderViewModel.confirmToDeliverParcel(
                    orderId,
                    sellerId,
                    orderByUser,
                    completeAddress,
                    context,
                    model!,
                );
              },
              child: Container(
                color: Colors.purple,
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Confirm - To Deliver this Parcel",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),

=======
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
              },
              child: Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
