import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double borderradius = 10.0;
    double widthButton = 300.0;
    double heightButton = 40.0;
    double policyTextSize = 14;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xC8C8C8),
        title: const Text('Hello Agian!')
      ),
      body: Center(
        
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SignInButton(
              Buttons.Google,
              
              text: "Sign up with Google",
              onPressed: () {},
            ),
            SignInButton(
              Buttons.Facebook,
              text: "Sign up with Facebook",
              onPressed: () {},
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter email",
                labelText: "Username"
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter password",
                labelText: "Password"
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Colors.white,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(borderradius)),
                minimumSize: Size(widthButton, heightButton)
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              
              child: const Text(
                
                'Log In',
                style: TextStyle(height: 1.0, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              child: new Text(
                'Forget password?',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: policyTextSize),
                ),
              onTap:  () async {
              final Uri uri = Uri(scheme: 'https', host: 'www.github.com');
              await launchUrl(uri);
              //cant launch at the moment, because emualtor has no internet
              /*
              if(await canLaunchUrl(url)){
                await launchUrl(url);
              }
              else{
                throw "cannot load Url";
              }
              */
              }
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: policyTextSize),
                    text: "Don't haven an account? "
                  ),
                  TextSpan(
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: policyTextSize),
                    text: "Sign up",
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.of(context).pushNamed('/signup');
                      //cant launch at the moment, because emualtor has no internet
                      /*
                      if(await canLaunchUrl(url)){
                        await launchUrl(url);
                      }
                      else{
                        throw "cannot load Url";
                      }
                      */
                    }
                  ),
                ]
                ),
            ),
            const SizedBox(height:100),
            
            Container(
              constraints: BoxConstraints(minWidth: 350,maxWidth:350),
              padding: EdgeInsets.all(10),
              child: PolicyWidget(),
            ),
            
            
          ] 
        ),
        
      )
    );
  }
}