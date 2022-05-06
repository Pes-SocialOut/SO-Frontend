/*
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/signup_screen.dart';
import '../services/signIn_google.dart';
class loggedInWidget extends StatelessWidget {
  const loggedInWidget({ Key? key }) : super(key: key);

  

  Widget _buildBody() {
    return Scaffold (
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async{
              await GoogleSignInApi.logout2();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SignUpScreen()
                ));
            }, 
            child: Text('Logout'))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: const [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage:  NetworkImage(user!.photoUrl),
            ),
            SizedBox(height: 8),

            Text(
              'Name: '+user.displayName,
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            SizedBox(height: 8),

            Text(
              'Email: '+user.email,
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
          ]
          ),
      ),
    );
  }

  
}
*/
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/services/signIn_google.dart';
class loggedInWidget extends StatelessWidget {
  const loggedInWidget({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Log Out'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Are you sure?"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            GoogleSignInApi.logout2();
            Navigator.of(context).pushNamed('/welcome');
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Yes'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('No'),
        ),
      ],
    );
  }
}