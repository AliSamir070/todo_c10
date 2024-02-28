import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/layout/home/home_screen.dart';
import 'package:todo_c10_maadi/layout/login/login_screen.dart';
import 'package:todo_c10_maadi/shared/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      CheckAutoLogin();
    });
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/splash.jpg"),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
  CheckAutoLogin() async {
    Authprovider provider = Provider.of<Authprovider>(context,listen: false);
    if(provider.isFirebaseUserLoggedIn()){
      await provider.retrieveDatabaseUserData();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }else{
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}
