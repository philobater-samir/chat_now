import 'package:chat_route_course/Model/User.dart';

abstract class createAccountNavigator{
  void showLoading ();
  void hideLoading ();
  void showMessage (String message);
  void navigateToHome(MyUser user);
  void navigateToCreateAcc();
}