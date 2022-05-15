import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double policyTextSize = 14;
    return  RichText(
      textAlign: TextAlign.justify,
      
      text: TextSpan(
        children: [
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: policyTextSize),
            text: "By continuing, you agree to SocialOut's "
          ),
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: policyTextSize),
            text: "Terms of Services",
            recognizer: TapGestureRecognizer()..onTap = () async {
              final Uri uri = Uri(scheme: 'https', host: 'pages.flycricket.io', path:'socialout-0/terms');
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
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: policyTextSize),
            text: ". We will manage information about you as described in our "
          ),
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: policyTextSize),
            text: "Privacy",
            recognizer: TapGestureRecognizer()..onTap = () async {
              final Uri uri = Uri(scheme: 'https', host: 'pages.flycricket.io', path:'socialout/privacy');
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
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: policyTextSize),
            text: " and "
          ),
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: policyTextSize),
            text: "Cookie Policy",
            recognizer: TapGestureRecognizer()..onTap = () async {
              final Uri uri = Uri(scheme: 'https', host: 'pages.flycricket.io', path:'socialout/privacy');
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
          TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: policyTextSize),
            text: "."
          ),
        ]
      )
      
       
    );
  }
}