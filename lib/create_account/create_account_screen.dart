import 'dart:async';

import 'package:chat_route_course/Home/home_screen.dart';
import 'package:chat_route_course/Model/User.dart';
import 'package:chat_route_course/create_account/createAccount_Navigator.dart';
import 'package:chat_route_course/create_account/create_account_view_model.dart';
import 'package:chat_route_course/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_route_course/Utils.dart' as Utils;

class createAccountScreen extends StatefulWidget {
  static const String routeName = 'createAccountScreen';

  @override
  State<createAccountScreen> createState() => _createAccountScreenState();
}

class _createAccountScreenState extends State<createAccountScreen>
    implements createAccountNavigator {
  String userName = '';

  String email = '';

  String password = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  createAccountViewModel viewModel = createAccountViewModel();

  @override
  void initState() {
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
                'Create Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              toolbarHeight: 100,
            ),
            body: Container(
              margin: EdgeInsets.only(top: hieght * .140),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: hieght * .09,
                          ),
                          Center(
                              child: Text(
                            ' Welcome ! ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              userName = text;
                            },
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter your User Name ';
                              }
                              return null;
                            },
                            autocorrect: true,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'User Name',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              email = text;
                            },
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
                            autocorrect: true,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              password = text;
                            },
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter your Password ';
                              }
                              if (text.trim().length < 6) {
                                return ' your Password Is Short must be at least 6 ';
                              }
                              return null;
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
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              validateForm();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Create Account ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.createAccountData(email, password, context, userName);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context, 'Loading......');
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'Ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigateToHome(MyUser user) {
    var provider =Provider.of<userProvider>(context,listen: false);
    provider.user = user ;
    Navigator.of(context).pushReplacementNamed(home.routeName);
  }

  @override
  void navigateToCreateAcc() {
    Timer(Duration(seconds: 5),(){
      Navigator.of(context).pushNamed(createAccountScreen.routeName);
    });
  }


}
