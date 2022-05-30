import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:so_frontend/feature_chat/data_local/data.dart';
import 'package:so_frontend/feature_chat/services/chat_service.dart';
import 'package:so_frontend/feature_chat/widgets/chat_widget.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/utils/api_controller.dart';

class ChatScreen extends StatelessWidget {
  final String eventId;
  ChatScreen({Key? key, required this.eventId}) : super(key: key);
  final chatAPI cAPI = chatAPI();
  DateTime _lastQuitTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () async {
                    final difference = DateTime.now().difference(_lastQuitTime);
                    final isExitWarning = difference >= Duration(seconds: 2);

                    _lastQuitTime = DateTime.now();

                    if (isExitWarning) {
                      final message = 'Press back again to quit chat';
                      print('Press back again to exit');
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  //backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Name of Event",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "#Members",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: WillPopScope(
            onWillPop: () async {
              final difference = DateTime.now().difference(_lastQuitTime);
              final isExitWarning = difference >= Duration(seconds: 2);

              _lastQuitTime = DateTime.now();

              if (isExitWarning) {
                final message = 'Press back again to quit chat';
                print('Press back again to exit');
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
                return false;
              } else {
                return true;
              }
            },
            child: Stack(
              children: [
                Container(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 70),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      //for each message
                      double paddingSelf = 30;
                      double paddingOther = 10;
                      //hardcode
                      bool messageMine = messages[index].senderID ==
                          "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f";
                      return Container(
                        //icon+message
                        alignment: messageMine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: messageMine ? paddingSelf : paddingOther,
                            right: messageMine ? paddingOther : paddingSelf,
                            top: 10,
                            bottom: 10),
                        child: Align(
                            alignment: (messageMine
                                ? Alignment.topRight
                                : Alignment.topLeft),
                            child: Row(
                              mainAxisAlignment: messageMine
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: <Widget>[
                                if (!messageMine)
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/gato.jpg')
                                            as ImageProvider,
                                    //sender's icon
                                    maxRadius: 20,
                                  ),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: messageMine
                                              ? Radius.circular(20)
                                              : Radius.circular(0),
                                          topRight: messageMine
                                              ? Radius.circular(0)
                                              : Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(
                                              20)), //BorderRadius.circular(20),
                                      color: (messageMine
                                          //?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.onSecondary
                                          ? HexColor('80ED99')
                                          : Colors.white),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      messages[index].messageContent,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                if (messageMine)
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/dog.jpg')
                                            as ImageProvider,
                                    //user's icon
                                    //backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                                    maxRadius: 20,
                                  ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
                SendWidget(eventId: eventId),
              ],
            )),
        /*
        children: <Widget>[
          
          ListView.builder(
            
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10
            ),
            
            physics: AlwaysScrollableScrollPhysics(),
            
            itemBuilder: (context, index){
              
              //for each message
              double paddingSelf = 30;
              double paddingOther = 10;
              //hardcode
              bool messageMine = messages[index].senderID == "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f";
              return Container(//icon+message
                alignment: messageMine?Alignment.centerRight:Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: messageMine?paddingSelf:paddingOther,
                  right: messageMine?paddingOther:paddingSelf,
                  top: 10,
                  bottom: 10
                ),
                child: Align(
                  alignment: (
                    messageMine
                    ?Alignment.topRight:Alignment.topLeft
                  ),
                  child: Row(
                    mainAxisAlignment: messageMine?MainAxisAlignment.end:MainAxisAlignment.start,
                    children: <Widget>[
                        if(!messageMine)
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/gato.jpg') as ImageProvider,
                            //sender's icon
                            maxRadius: 20,
                          ),
                        Flexible(
                          
                          child: Container(
                            
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: messageMine?Radius.circular(20):Radius.circular(0),
                                topRight: messageMine?Radius.circular(0):Radius.circular(20),
                                bottomLeft: Radius.circular(20), 
                                bottomRight: Radius.circular(20)
                              ),//BorderRadius.circular(20),
                              color: (
                                messageMine
                                //?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.onSecondary
                                ?HexColor('80ED99'):Colors.white
                              ),
                            ),
                            padding: EdgeInsets.all(12),
                            
                            child: Text(
                              messages[index].messageContent, 
                              style: TextStyle(fontSize: 15),
                            ),
                        
                        ),
                          
                        ), 
                        
                        if(messageMine)
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg') as ImageProvider,
                            //user's icon
                            //backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                            maxRadius: 20,
                          ),
                    ],
                  )
                 
                ),
                
              );
              
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      APICalls api = APICalls();
                      future: api.getCollection('/v2/events/:0/:1', ['joined', api.getCurrentUser()], null);
                      String aux_s = APICalls().getCurrentUser();
                      String accessToken = APICalls().getCurrentAccess();
                      cAPI.getEvents(aux_s);
                      print(accessToken);
                      
                      cAPI.createChat(aux_s, APICalls().getCurrentUser());
                    },
                    child: Icon(Icons.send, color: Theme.of(context).colorScheme.primary,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
        ],*/
      ),
    );
  }
}
