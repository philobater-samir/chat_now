import 'package:chat_route_course/Home/home_screen.dart';
import 'package:chat_route_course/chat/chat_navigator.dart';
import 'package:chat_route_course/chat/chat_screen.dart';
import 'package:chat_route_course/create_account/create_account_screen.dart';
import 'package:chat_route_course/create_chat/create_chat_screen.dart';
import 'package:chat_route_course/login/Login_screen.dart';
import 'package:chat_route_course/provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context)=> userProvider(),
      child: chatNow()));
}
class chatNow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<userProvider>(context);
    return MaterialApp(
      routes: {
        loginScreen.routeName:(context)=>loginScreen(),
        home.routeName:(context)=>home(),
        createAccountScreen.routeName:(context)=>createAccountScreen(),
        createChat.routeName:(context)=>createChat(),
        chatScreen.routeName:(context)=>chatScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser == null ? loginScreen.routeName : home.routeName ,
    );
  }
}
