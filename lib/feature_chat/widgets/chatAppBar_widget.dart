import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  const AppBarWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              Icon(Icons.more_vert,color: Theme.of(context).colorScheme.primary,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}