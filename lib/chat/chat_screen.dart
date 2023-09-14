import 'package:chat_route_course/Model/chat.dart';
import 'package:chat_route_course/Model/message.dart';
import 'package:chat_route_course/chat/chat_navigator.dart';
import 'package:chat_route_course/chat/chat_view_model.dart';
import 'package:chat_route_course/chat/message_wedgit.dart';
import 'package:chat_route_course/provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_route_course/Utils.dart' as Utils;


class chatScreen extends StatefulWidget {
  static const String routeName = 'chatScreen';

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> implements chatNavigator {
  chatScreenViewModel viewModel = chatScreenViewModel();
  String messageContent = '' ;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Chat;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    viewModel.chat = args ;
    var provider = Provider.of<userProvider>(context);
    viewModel.currentUser = provider.user!;
    viewModel.updateChatMessage();
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(children: [
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
                  args.chatName ?? "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                toolbarHeight: 100,
              ),
              body: Padding(
                  padding:
                      EdgeInsets.only(top: height * .0001,),
                  child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Padding(
                            padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(child:StreamBuilder<QuerySnapshot<Message>>(
                                    builder:(context,asyncSnapSot){
                                      if(asyncSnapSot.connectionState == ConnectionState.waiting){
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                        );
                                      }
                                      if (asyncSnapSot.hasError){
                                        return Text('Someting Went Wrong',style: TextStyle(color: Colors.blue,fontSize: 15));
                                      }
                                      else
                                      {
                                        var messageList = asyncSnapSot.data?.docs.map((doc) => doc.data()).toList()??[];
                                        return ListView.builder(
                                            itemBuilder: (context,index){
                                              return messageWidget(message: messageList[index]);
                                            } ,
                                            itemCount: messageList.length,
                                            );
                                      }
                                    } ,
                                    stream: viewModel.streamMessage,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                            child: TextField(
                                              autocorrect: true,
                                              maxLength: 1000,
                                              keyboardType: TextInputType.multiline ,
                                              controller: controller,
                                              onChanged: (text){
                                                messageContent = text ;
                                              },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(5),
                                            hintText: 'Type  a message',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(15,),bottomLeft: Radius.circular(15))
                                            )
                                          ),

                                        )),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          flex: 1,
                                            child: ElevatedButton(
                                                onPressed: (){
                                                  viewModel.sentMessage(messageContent);
                                                }, child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Icon(Icons.send,),
                                                )))

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )))))
        ]));
  }

  @override
  void showMessage(String message)  {
    Utils.showMessage(message, context, "Ok", (context){
      Navigator.pop(context);
    });
  }
  @override
  void clearMessage() {
    controller.clear();
  }
}
