import 'package:flutter/material.dart';
import 'package:medicinereminder/auth.dart';
import 'package:medicinereminder/splashscreen.dart';
import 'package:medicinereminder/login.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key:key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return const SplashScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
