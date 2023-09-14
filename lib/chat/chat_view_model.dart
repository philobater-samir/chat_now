import 'package:chat_route_course/Model/User.dart';
import 'package:chat_route_course/Model/chat.dart';
import 'package:chat_route_course/Model/message.dart';
import 'package:chat_route_course/chat/chat_navigator.dart';
import 'package:chat_route_course/firebase/Firebase_Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chatScreenViewModel  extends ChangeNotifier{
late chatNavigator navigator ;
late MyUser currentUser ;
late Chat chat ;
void sentMessage(String content)async{
  Message message = Message(
      chatId: chat.chatId,
      content: content,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderId: currentUser.id,
      senderName: currentUser.userName);
  try {
    var res = await firebaseUsers.insertMessage(message);
    navigator.clearMessage();

  }catch(e){
    navigator.showMessage(e.toString());
  }
}
late Stream<QuerySnapshot<Message>> streamMessage ;
void updateChatMessage(){
  streamMessage = firebaseUsers.getMessageFromFireStore(chat.chatId);

}
}