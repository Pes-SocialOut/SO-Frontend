import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:so_frontend/feature_chat/data_local/data.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.primary,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  //backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Name of Event",style: TextStyle( color: Theme.of(context).colorScheme.onBackground,fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text("#Members",style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 13),),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  
                 icon: Icon(Icons.more_vert,color: Theme.of(context).colorScheme.primary,),
                )
                
              ],
            ),
          ),
        ),
      ),
      
      body: Stack(
        
        alignment: Alignment.topRight,
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
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Theme.of(context).colorScheme.primary, size: 20, ),
                    ),
                  ),
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
                    onPressed: (){},
                    child: Icon(Icons.send, color: Theme.of(context).colorScheme.primary,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}