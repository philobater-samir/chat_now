import 'dart:async';

import 'package:chat_route_course/Home/home_screen.dart';
import 'package:chat_route_course/Model/User.dart';
import 'package:chat_route_course/create_account/create_account_screen.dart';
import 'package:chat_route_course/login/login_Navigator.dart';
import 'package:chat_route_course/login/login_view_model.dart';
import 'package:chat_route_course/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_route_course/Utils.dart' as Utils;

class loginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> implements loginNavigator {
  String email = '';

  String password = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  loginViewModel viewModel = loginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/images/background_app.png',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              toolbarHeight: 100,
            ),
            body: Container(
              margin: EdgeInsets.only(top: hieght * .2),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome Back ! ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            onChanged: (text) {
                              email = text;
                            },
                            autocorrect: true,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter your Email ';
                              }
                              var emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return 'Email format Not Valid';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              password = text;
                            },
                            autocorrect: true,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter your Password ';
                              }
                              if (text.trim().length < 6) {
                                return ' your Password Is Short must be at least 6 ';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              validateForm();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                ' Login ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(createAccountScreen.routeName);
                                },
                                child: Text(
                                  'Or Create Your Account ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.loginData(email, password, context);
    }
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context, 'Loading....');
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'Ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigateToHome(MyUser user) {
    var provider = Provider.of<userProvider>(context,listen: false);
    provider.user = user ;

    Navigator.of(context).pushReplacementNamed(home.routeName);
  }

  @override
  void navigateToLogin() {
    Timer(Duration(seconds: 5),(){
      Navigator.of(context).pushNamed(loginScreen.routeName);
    });
  }




}




