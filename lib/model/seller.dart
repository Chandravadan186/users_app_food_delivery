class Seller
{
  String? uid;
  String? email;
  String? name;
  String? image;
  String? phone;
  String? address;
  String? status;
<<<<<<< HEAD
  double? earnings;
=======

>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
  double? latitude;
  double? longitude;

  Seller({
    this.uid,
    this.email,
    this.name,
    this.image,
    this.phone,
    this.address,
    this.status,
<<<<<<< HEAD
    this.earnings,
=======

>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
    this.latitude,
    this.longitude,
  });

  Seller.fromJson(Map<String, dynamic> json)
  {
    uid = json["uid"];
    email = json["email"];
    name = json["name"];
    image = json["image"];
    phone = json["phone"];
    address = json["address"];
    status = json["status"];
<<<<<<< HEAD
    earnings = json["earnings"];
=======

>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
    latitude = json["latitude"];
    longitude = json["longitude"];
  }
}