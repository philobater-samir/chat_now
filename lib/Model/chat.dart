class Chat {
  static const String collectionName = 'chats' ;
  String chatId ;
  String? chatName;
  String? categoryId;
  Chat({
    required this.chatName,required this.categoryId,required this.chatId
});
  Chat.fromJson(Map<String,dynamic>json):this(
    categoryId: json['category_id'] ,
    chatId: json['chat_id'] ,
    chatName: json['chat_name'] ,

  );

  Map<String,dynamic>toJson(){
    return{
      'category_id' : categoryId,
      'chat_id' : chatId,
      'chat_name' : chatName
    };
  }
}