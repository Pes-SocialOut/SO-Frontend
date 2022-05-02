import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:so_frontend/feature_user/services/signIn_google.dart';
import 'package:so_frontend/feature_user/widgets/loggedIn_widget.dart';
import 'signup_screen.dart';

class LoggedInPage extends StatelessWidget{
  final GoogleSignInAccount user;
  LoggedInPage({
    Key ? key,
    required this.user,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold (
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async{
              showDialog(
                  context: context,
                  builder: (BuildContext context) => loggedInWidget(),
                );
            }, 
            child: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 20),))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage:  NetworkImage(user.photoUrl!),
            ),
            SizedBox(height: 8),

            Text(
              'Name: '+user.displayName!,
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            SizedBox(height: 8),

            Text(
              'Email: '+user.email,
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            SizedBox(height: 8),

            Text(
              'Auth: '+user.authentication.toString(),
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            ElevatedButton(
              child: const Text('SIGN OUT'),
              onPressed: () async{
                showDialog(
                  context: context,
                  builder: (BuildContext context) => loggedInWidget(),
                );
                //GoogleSignInApi.logout();
                //Navigator.of(context).pushNamed('/welcome');
              } 
            ),
          ]
          ),
      ),
  );


}