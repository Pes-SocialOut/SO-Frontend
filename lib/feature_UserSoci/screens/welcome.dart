import 'package:flutter/material.dart';
import 'package:so_frontend/feature_UserSoci/widgets/welcome_widget.dart';

class UserSociScreen extends StatelessWidget {
  const UserSociScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/frontpage/frontpage_1.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                

                Text('Search your near events',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                WelcomeWidget()
              ],
            ),
          )
        ),
      ],
    );
     
  }
}