import 'package:chat_route_course/Model/chat.dart';
import 'package:chat_route_course/create_chat/create_chat_Navigator.dart';
import 'package:chat_route_course/firebase/Firebase_Users.dart';
import 'package:flutter/material.dart';

class createChatViewModel extends ChangeNotifier{
late createChatNavigator navigator ;
void addChat(String chatName, String categoryId)async{
  Chat chat = Chat(chatName: chatName, categoryId: categoryId, chatId: '');
  try {
    navigator.showLodaing();
    var createChat = await firebaseUsers.addChatToFireStore(chat);
    navigator.hideLoading();
    navigator.navigateToHome();

  }catch(e){
    navigator.hideLoading();
    navigator.showMessage('Something Went Wrong');
  }

}
}