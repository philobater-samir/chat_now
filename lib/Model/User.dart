
class MyUser{
  String id ;
  String userName;
  String email ;

  MyUser({required this.email,required this.userName, required this.id});

  Map<String,dynamic> toJSon(){
    return {
      "id":id ,
      "userName" : userName,
      "email" : email ,
    };
  }
  MyUser.fromJson (Map<String,dynamic> json):this(
    id: json["id"] as String ,
    userName: json["userName"] as String,
    email: json["email"] as String,
  );
}