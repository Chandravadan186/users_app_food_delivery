import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:riders_app/view/authScreens/signin_screen.dart';
import 'package:riders_app/view/authScreens/signup_screen.dart';
=======
import 'package:users_app/view/authScreens/signin_screen.dart';
import 'package:users_app/view/authScreens/signup_screen.dart';
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a



class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
<<<<<<< HEAD
            "iFood",
=======
            "QuickCart",
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Sign in",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.white,),
                text: "Signup",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5,
          ),
        ),
        body: Container(
          color: Colors.black87,
          child: const TabBarView(
            children: [
              SigninScreen(),
              SignupScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
