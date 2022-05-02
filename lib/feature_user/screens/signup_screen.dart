import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/screens/loggedIn_screen.dart';
import 'package:so_frontend/feature_user/services/signIn_google.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderradius = 10.0;
    double widthButton = 300.0;
    double heightButton = 40.0;
    double policyTextSize = 14;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xC8C8C8),
        title: const Text('Sign Up')
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 60),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: SignInButton(
                  Buttons.Google,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderradius)),
                  text: "Continue with Google",
                  onPressed: () =>_handleSignIn(context),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: SignInButton(
                  Buttons.Facebook,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderradius)),
                  text: "Continue with Facebook",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "OR",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                  
                  ),
              ), 
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: SignInButton(
                  Buttons.Email,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderradius)),
                  text: "Continue with Email",
                  onPressed: () {},
                ),
              ),
                   
             
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: policyTextSize),
                        text: "Already have an account? "
                      ),
                      TextSpan(
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: policyTextSize),
                        text: "Log In",
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.of(context).pushNamed('/login');
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
              ),
              const SizedBox(height: 60),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const PolicyWidget(),
              ),              
              
            
            
            ] 
          )
          
          
        ),
        
      )
    );
    
  }

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final user = await GoogleSignInApi.login();
      
      if(user == null){
        Navigator.of(context).pushNamed('/welcome');
        ScaffoldMessenger.of(context).showSnackBar(
          
          const SnackBar(
            content: 
            Text('Sign in Failed, please try again')
            )
          );
      }else{
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=> LoggedInPage(user: user,),
          ));
      }
    }
     catch ( error) {
      
      print(error);
    }
  }

  
  Future signIn( BuildContext context) async{
      final user = await GoogleSignInApi.login();
      
      if(user == null){
        Navigator.of(context).pushNamed('/login');
        ScaffoldMessenger.of(context).showSnackBar(
          
          const SnackBar(
            content: 
            Text('Sign in Failed')
            )
          );
      }else{
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=> LoggedInPage(user: user,),
          ));
      }
    }
}