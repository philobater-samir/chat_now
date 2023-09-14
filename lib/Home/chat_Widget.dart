import 'package:chat_route_course/Model/category.dart';
import 'package:chat_route_course/Model/chat.dart';
import 'package:chat_route_course/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class chatWidget extends StatelessWidget {
  Chat? chat ;
  CategoryDrop category = CategoryDrop();
  chatWidget({required this.chat,required this.category});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(chatScreen.routeName,arguments: chat);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0 , 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Image.asset(category?.image??"",height: 80, ),
            SizedBox(height: 10,),
            Text(chat?.chatName??"",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }
}
