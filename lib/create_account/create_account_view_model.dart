import 'package:chat_route_course/Model/User.dart';
import 'package:chat_route_course/create_account/createAccount_Navigator.dart';
import 'package:chat_route_course/firebase/Firebase_Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class createAccountViewModel extends ChangeNotifier {
  late createAccountNavigator navigator;
  void createAccountData(String email, String password, BuildContext context,
      String userName) async {
    navigator.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator.hideLoading();

      MyUser user = MyUser(
          email: email, userName: userName, id: credential.user?.uid ?? '');
      var result = await firebaseUsers.createDBUser(user);
      navigator.navigateToHome(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.showMessage('weak password');
        navigator.navigateToCreateAcc();
      } else if (e.code == 'email-already-in-use') {
        navigator.showMessage('email already in use');
        navigator.navigateToCreateAcc();
      }
    } catch (e) {}
  }
}
