import 'package:chat_route_course/Model/message.dart';
import 'package:chat_route_course/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class messageWidget extends StatelessWidget {
  Message message;
  messageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var provier = Provider.of<userProvider>(context);
    return provier.user?.id == message.senderId
        ? sentMessage(message: message)
        : recieveMessage(message: message);
  }
}

class sentMessage extends StatelessWidget {
  Message message;
  sentMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )),
            child: Text(message.content, style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }
}

class recieveMessage extends StatelessWidget {
  Message message;
  recieveMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            child: Text(message.content),
          ),
        ),
      ],
    );
  }
}
