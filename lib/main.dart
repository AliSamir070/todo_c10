import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/layout/home/provider/home_provider.dart';
import 'package:todo_c10_maadi/layout/login/login_screen.dart';
import 'package:todo_c10_maadi/layout/register/register_screen.dart';
import 'package:todo_c10_maadi/shared/providers/auth_provider.dart';
import 'package:todo_c10_maadi/style/theme.dart';

import 'firebase_options.dart';
import 'layout/home/home_screen.dart';
import 'layout/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Authprovider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routeName:(_)=>ChangeNotifierProvider(
            create: (_)=>HomeProvider(),
            child: HomeScreen()),
        SplashScreen.routeName:(_)=>SplashScreen()
      },
      initialRoute:SplashScreen.routeName,
    );
  }
}

