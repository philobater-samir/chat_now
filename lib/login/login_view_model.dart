import 'package:chat_route_course/firebase/Firebase_Users.dart';
import 'package:chat_route_course/login/login_Navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class loginViewModel extends ChangeNotifier{
  late loginNavigator navigator;
  void loginData(String email , String password, BuildContext context)async{
    navigator.showLoading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var userLogin = await firebaseUsers.readUser(credential.user?.uid ?? ' ');
      navigator.hideLoading();
      if(userLogin != null ){
        Future.delayed(Duration(microseconds: 2),(){
          navigator.navigateToHome(userLogin);

        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.showMessage('User not found');
        navigator.navigateToLogin();
      } else if (e.code == 'wrong-password') {
        navigator.showMessage('wrong-password');
        navigator.navigateToLogin();
      }
    }
  }
  }
