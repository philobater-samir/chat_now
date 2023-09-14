import 'dart:async';

import 'package:chat_route_course/Home/home_screen.dart';
import 'package:chat_route_course/Model/category.dart';
import 'package:chat_route_course/create_chat/create_chat_Navigator.dart';
import 'package:chat_route_course/create_chat/create_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_route_course/Utils.dart' as Utils;


class createChat extends StatefulWidget {
  static const String routeName = 'createChat';

  @override
  State<createChat> createState() => _createChatState();
}

class _createChatState extends State<createChat>
    implements createChatNavigator {
  createChatViewModel viewModel = createChatViewModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String chatName = '';
  late CategoryDrop chooseCategory;
  var categoryList = CategoryDrop.getCategory();
  CategoryDrop? selectedItem;

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                'Create Chat',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              toolbarHeight: 100,
            ),
            body: Padding(
              padding: EdgeInsets.only(top: height * .01,),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: height * .8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                'Create New Chat',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset(
                              'assets/images/create_chat.png',
                              width: width * .7,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Enter Chat Name',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10))),
                              onChanged: (text) {
                                chatName = text;
                              },
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'Please Enter Chat Name';
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButton<CategoryDrop>(
                                        isExpanded: true,
                                        iconSize: 12,
                                        disabledHint: Text('Choose Category'),
                                        value: selectedItem,
                                        items: categoryList
                                            .map((category) =>
                                                DropdownMenuItem<CategoryDrop>(
                                                  value: category,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(category?.name??''),
                                                      Image.asset(category?.image??'')
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (newCategory) {
                                          selectedItem = newCategory;
                                          setState(() {});
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100)),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      validateForm();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Add Chat',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
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

  void validateForm() {
    if(formKey.currentState ?. validate() == true){
      viewModel.addChat(chatName, selectedItem?.id??'');
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void navigateToHome() {
    Timer(Duration(seconds: 1),(){
      Navigator.of(context).pushReplacementNamed(home.routeName);
    });
  }

  @override
  void showLodaing() {
    Utils.showLoading(context, 'Loading...');
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'OK', (context){
      Navigator.pop(context);
    });
  }
}
