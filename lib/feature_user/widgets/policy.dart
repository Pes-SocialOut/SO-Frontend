import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "By continuing, you agree to SocialOut\'s "
          ),
          TextSpan(
            text: "Terms of Services",
            recognizer: TapGestureRecognizer()..onTap = () async {
              final Uri uri = Uri(scheme: 'https', host: 'www.google.com');
              if(await canLaunchUrl(uri)){
                await launchUrl(uri);
              }
              else{
                throw "cannot load Url";
              }
            }
          ),
          const TextSpan(
            text: ". We will manage information about you as described in our "
          ),
          TextSpan(
            text: "Privacy",
            recognizer: TapGestureRecognizer()..onTap = () async {
              final Uri uri = Uri(scheme: 'https', host: 'www.github.com');
              if(await canLaunchUrl(uri)){
                await launchUrl(uri);
              }
              else{
                throw "cannot load Url";
              }
            }
          ),
          const TextSpan(
            text: " and "
          ),
          TextSpan(
            text: "Cookie Policy",
            recognizer: TapGestureRecognizer()..onTap = () async {
              final Uri uri = Uri(scheme: 'https', host: 'www.youtube.com');
              if(await canLaunchUrl(uri)){
                await launchUrl(uri);
              }
              else{
                throw "cannot load Url";
              }
            }
          ),
          const TextSpan(
            text: "."
          ),
        ]
      )
      
       
    );
  }
}