import 'package:chat_route_course/Model/User.dart';
import 'package:chat_route_course/Model/chat.dart';
import 'package:chat_route_course/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class firebaseUsers{
  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
        fromFirestore: ((snapshot,options)=>MyUser.fromJson(snapshot.data()!) ),
        toFirestore: (user,options)=> user.toJSon());

  }
  static CollectionReference<Chat> getChatCollection(){
    return FirebaseFirestore.instance.collection(Chat.collectionName).withConverter<Chat>(
        fromFirestore: ((snapshot,options)=>Chat.fromJson(snapshot.data()!) ),
        toFirestore: (chat,options)=> chat.toJson());

  }

  static Future<void> createDBUser(MyUser user){
    return getUsersCollection().doc(user.id).set(user);
  }
  static Future <MyUser?> readUser(String userId)async{
    DocumentSnapshot <MyUser> documentSnapshot= await getUsersCollection().doc(userId).get();
    return documentSnapshot.data();
  }

  static Future <void> addChatToFireStore(Chat chat)async{
    var docRef = getChatCollection().doc();
    chat.chatId = docRef.id ;
    return docRef.set(chat);
  }

  static Stream<QuerySnapshot<Chat>> getChats (){
     return getChatCollection().snapshots();
  }

  static CollectionReference<Message> getUserMessageCollection(String chatId){
    return FirebaseFirestore.instance.collection(Chat.collectionName).doc(chatId).collection(Message.collectionName).withConverter<Message>(
        fromFirestore: ((snapshot,options)=>Message.fromJson(snapshot.data()!) ),
        toFirestore: (message,options)=> message.toJson());






  }

  static Future<void> insertMessage(Message message){
    var messageCollection = getUserMessageCollection(message.chatId);
    var docRef = messageCollection.doc();
    message.id = docRef.id ;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessageFromFireStore(String chatId) {
    return getUserMessageCollection(chatId).orderBy('date_time').snapshots();
  }
}