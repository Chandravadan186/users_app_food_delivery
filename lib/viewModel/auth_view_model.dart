import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../global/global_instances.dart';
import '../global/global_vars.dart';
import '../view/mainScreens/home_screen.dart';

class AuthViewModel
{
<<<<<<< HEAD
  validateSignUpForm(XFile? imageXFile, String password, String confirmPassword, String name, String email, String phone, String locationAddress, BuildContext context) async
=======
  validateSignUpForm(XFile? imageXFile, String password, String confirmPassword, String name, String email, BuildContext context) async
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
  {
    if(imageXFile == null)
    {
      commonViewModel.showSnackBar("Please select image file.", context);
      return;
    }
    else
    {
      if(password == confirmPassword)
      {
<<<<<<< HEAD
        if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && phone.isNotEmpty && locationAddress.isNotEmpty)
=======
        if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty)
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
        {
          commonViewModel.showSnackBar("Please wait...", context);

          User? currentFirebaseUser = await createUserInFirebaseAuth(email, password, context);

          String downloadUrl = await uploadImageToStorage(imageXFile);

<<<<<<< HEAD
          await saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name, email, password, locationAddress, phone);
=======
          await saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name, email, password);
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a

          Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));

          commonViewModel.showSnackBar("Account Created Successfully.", context);
        }
        else
        {
          commonViewModel.showSnackBar("please fill all fields.", context);
          return;
        }
      }
      else
      {
        commonViewModel.showSnackBar("password do not match.", context);
        return;
      }
    }
  }

  createUserInFirebaseAuth(String email, String password, BuildContext context) async
  {
    User? currentFirebaseUser;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((valueAuth)
    {
      currentFirebaseUser = valueAuth.user;
    }).catchError((errorMsg)
    {
      commonViewModel.showSnackBar(errorMsg, context);
    });

    if(currentFirebaseUser == null)
    {
      FirebaseAuth.instance.signOut();
      return;
    }

    return currentFirebaseUser;
  }

  uploadImageToStorage(XFile? imageXFile) async
  {
    String downloadUrl = "";

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
<<<<<<< HEAD
    fStorage.Reference storageRef = fStorage.FirebaseStorage.instance.ref().child("ridersImages").child(fileName);
=======
    fStorage.Reference storageRef = fStorage.FirebaseStorage.instance.ref().child("usersImages").child(fileName);
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
    fStorage.UploadTask uploadTask = storageRef.putFile(File(imageXFile!.path));
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    await taskSnapshot.ref.getDownloadURL().then((urlImage)
    {
      downloadUrl = urlImage;
    });

    return downloadUrl;
  }

<<<<<<< HEAD
  saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name, email, password, locationAddress, phone) async
  {
    FirebaseFirestore.instance.collection("riders").doc(currentFirebaseUser.uid)
=======
  saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name, email, password) async
  {
    FirebaseFirestore.instance.collection("users").doc(currentFirebaseUser.uid)
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
        .set(
        {
          "uid": currentFirebaseUser.uid,
          "email": email,
          "name": name,
          "image": downloadUrl,
<<<<<<< HEAD
          "phone": phone,
          "address": locationAddress,
          "status": "approved",
          "earnings": 0.0,
          "latitude": position!.latitude,
          "longitude": position!.longitude,
=======
          "status": "approved",
          "userCart": ["garbageValue"],
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
        });

    await sharedPreferences!.setString("uid", currentFirebaseUser.uid);
    await sharedPreferences!.setString("email", email);
    await sharedPreferences!.setString("name", name);
    await sharedPreferences!.setString("imageUrl", downloadUrl);
<<<<<<< HEAD
=======
    await sharedPreferences!.setStringList("userCart", ["garbageValue"]);
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
  }

  validateSignInForm(String email, String password, BuildContext context) async
  {
    if(email.isNotEmpty && password.isNotEmpty)
    {
      commonViewModel.showSnackBar("checking credentials...", context);

      User? currentFirebaseUser = await loginUser(email, password, context);

      await readDataFromFirestoreAndSetDataLocally(currentFirebaseUser, context);

      Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));

<<<<<<< HEAD
      commonViewModel.showSnackBar("logged-in successful.", context);
=======
      commonViewModel.showSnackBar("logged-in successfull.", context);
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
    }
    else
    {
      commonViewModel.showSnackBar("Password and Email are required.", context);
      return;
    }
  }

  loginUser(email, password, context) async
  {
    User? currentFirebaseUser;

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((valueAuth)
    {
      currentFirebaseUser = valueAuth.user;
    }).catchError((errorMsg)
    {
      commonViewModel.showSnackBar(errorMsg, context);
    });

    if(currentFirebaseUser == null)
    {
      FirebaseAuth.instance.signOut();
      commonViewModel.showSnackBar("error, you are not logged-in, Try Again.", context);
      return;
    }

    return currentFirebaseUser;
  }

  readDataFromFirestoreAndSetDataLocally(User? currentFirebaseUser, BuildContext context) async
  {
    await FirebaseFirestore.instance
<<<<<<< HEAD
        .collection("riders")
=======
        .collection("users")
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
        .doc(currentFirebaseUser!.uid)
        .get()
        .then((dataSnapshot) async
    {
      if(dataSnapshot.exists)
      {
        if(dataSnapshot.data()!["status"] == "approved")
        {
          await sharedPreferences!.setString("uid", currentFirebaseUser.uid);
          await sharedPreferences!.setString("email", dataSnapshot.data()!["email"]);
          await sharedPreferences!.setString("name", dataSnapshot.data()!["name"]);
          await sharedPreferences!.setString("imageUrl", dataSnapshot.data()!["image"]);
        }
        else
        {
          commonViewModel.showSnackBar("you are blocked by admin. Contact: alizeb875@gmail.com", context);
          FirebaseAuth.instance.signOut();
          return;
        }
      }
      else
      {
        commonViewModel.showSnackBar("This seller record do not exists.", context);
        FirebaseAuth.instance.signOut();
        return;
      }
    });
  }
}