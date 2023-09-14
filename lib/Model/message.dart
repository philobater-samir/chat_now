class Message {
  static const String collectionName = 'message' ;
  String content;
  String id;
  String chatId;
  String senderId;
  String senderName;
  int dateTime;
  Message(
      {this.id = '',
      required this.chatId,
      required this.content,
      required this.dateTime,
      required this.senderId,
      required this.senderName});

  Message.fromJson(Map<String,dynamic>json):this(
    id: json['id'] as String ,
    chatId: json['chat_id'] as String ,
    content: json['content'] as String ,
    dateTime: json['date_time'] as int ,
    senderId: json['sender_id'] as String ,
    senderName: json['sender_name'] as String ,
  );

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'chat_id' : chatId,
      'content' : content,
      'date_time' : dateTime,
      'sender_id' : senderId,
      'sender_name' : senderName,
    };
  }





}
