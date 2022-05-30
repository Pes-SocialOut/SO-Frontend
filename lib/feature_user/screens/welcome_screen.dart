import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/utils/go_to.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderradius = 10.0;
    double widthButton = 300.0;
    double heightButton = 40.0;

    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/frontpage/frontpage_1_small.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Image.asset(
                      "assets/Banner.png",
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width / 1.5,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'welcome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ).tr(),
                    const SizedBox(height: 300),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.secondary,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(borderradius)),
                          minimumSize: Size(widthButton, heightButton)),
                      onPressed: () async {
                        //final aux = uAPI.checkUserEmail("zjqtlwj@gmail.com");
                        //print(aux);
                        //String? key=await FlutterFacebookKeyhash.getFaceBookKeyHash ??
                        'Unknown platform version';
                        //print(key??"");
                        //FacebookSignInApi.logout2();
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: const Text(
                        'signUp',
                        style: TextStyle(
                            height: 1.0,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ).tr(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.onSecondary,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(borderradius)),
                          minimumSize: Size(widthButton, heightButton)),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/login', arguments: GoTo(
                          () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false)
                        ));
                      },
                      child: const Text(
                        'login',
                        style: TextStyle(
                            height: 1.0,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ).tr(),
                    )
                  ]),
            ))
      ],
    );
  }
}
