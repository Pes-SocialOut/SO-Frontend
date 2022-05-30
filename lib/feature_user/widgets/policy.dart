import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double policyTextSize = 14;
    return RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(children: [
          TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: policyTextSize),
              text: "Bycontinuing".tr()),
          TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: policyTextSize),
              text: "TermsofServices".tr(),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final Uri uri = Uri(
                      scheme: 'https',
                      host: 'pages.flycricket.io',
                      path: 'socialout-0/terms');
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
                }),
          TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: policyTextSize),
              text: "manage".tr()),
          TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: policyTextSize),
              text: "Privacy".tr(),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final Uri uri = Uri(
                      scheme: 'https',
                      host: 'pages.flycricket.io',
                      path: 'socialout/privacy');
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
                }),
          TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: policyTextSize),
              text: "and".tr()),
          TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: policyTextSize),
              text: "CookiePolicy".tr(),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final Uri uri = Uri(
                      scheme: 'https',
                      host: 'pages.flycricket.io',
                      path: 'socialout/privacy');
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
                }),
          TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: policyTextSize),
              text: "."),
        ]));
  }
}
