import 'package:chat_route_course/Model/User.dart';
import 'package:chat_route_course/firebase/Firebase_Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userProvider extends ChangeNotifier {
  MyUser ?  user ;
  User ?  firebaseUser ;
  userProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser ;
    initMyUser ();
}
  void initMyUser()async {
    if (firebaseUsers != null) {
      user = await firebaseUsers.readUser(firebaseUser?.uid??"");
    }
  }

}

