import 'package:chat_route_course/Login_screen.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(chatNow());
}
class chatNow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        loginScreen.routeName:(context)=>loginScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: loginScreen.routeName,
    );
  }
}
