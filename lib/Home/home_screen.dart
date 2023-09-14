import 'package:chat_route_course/Home/chat_Widget.dart';
import 'package:chat_route_course/Home/home_Navigator.dart';
import 'package:chat_route_course/Home/home_view_model.dart';
import 'package:chat_route_course/Model/category.dart';
import 'package:chat_route_course/Model/chat.dart';
import 'package:chat_route_course/create_chat/create_chat_screen.dart';
import 'package:chat_route_course/firebase/Firebase_Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> implements homeNavigator{
  homeViewModel viewModel = homeViewModel();
  CategoryDrop? category = CategoryDrop() ;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this ;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewModel,
      child: Stack(
        children: [
          Container(
            child: Image.asset('assets/images/background_app.png',fit: BoxFit.fill,height: double.infinity,width: double.infinity,),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'My Chat',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              toolbarHeight: 100,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search,size: 30,),
                  )
                )
              ],
            ),
            drawer: Drawer(
              width: 300,
              elevation: 0,
              child:Stack(
                children: [
                  Container(
                  child: Image.asset('assets/images/background_app.png',fit: BoxFit.fill,height: double.infinity,width: double.infinity,),
                ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: InkWell(
                        onTap: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.settings,size: 30,),
                            SizedBox(width:10 ,),
                            Text('Settings',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20),),

                          ],
                        ),
                      ),
                    ),
                  )
              ]),

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pushNamed(createChat.routeName);
              },
              child: Icon(Icons.add,size: 30,),
            ),
            body: StreamBuilder<QuerySnapshot<Chat>>(
              stream: firebaseUsers.getChats(),
              builder:(context,asyncSnapShot){
                if(asyncSnapShot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(
                     color: Colors.blue,
                    ),
                  );
                }
                else if (asyncSnapShot.hasError){
                  return Text('Someting Went Wrong',style: TextStyle(color: Colors.blue,fontSize: 15));

                }
                else {
                  var chatList = asyncSnapShot.data?.docs.map((doc) => doc.data()).toList()??[];
                  return GridView.builder(
                      itemBuilder: (context,index){
                        return chatWidget(chat: chatList[index],category:CategoryDrop.fromId(chatList[index].categoryId) ,);
                      },
                      itemCount: chatList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                      ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
