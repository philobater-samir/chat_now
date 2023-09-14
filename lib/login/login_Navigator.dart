import 'package:chat_route_course/Model/User.dart';
import 'package:flutter/material.dart';

abstract class loginNavigator{
  void showLoading ();
  void hideLoading ();
  void showMessage (String message);
  void navigateToHome(MyUser user);
  void navigateToLogin();
}