import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/screens/link_user.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final userAPI uapi = userAPI();
  late String email;
  late String password;
  late String verification;
  double borderradius = 10.0;
  double widthButton = 300.0;
  double heightButton = 40.0;
  double policyTextSize = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xC8C8C8),
            title: const Text('Hello Agian!')),
        body: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Google,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "Log in with Google",
                    onPressed: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "Log in with Facebook",
                    onPressed: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Enter email", labelText: "Username"),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "Sign up with Facebook",
                    onPressed: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Enter email", labelText: "Email"),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return "a valid email is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value.toString();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "a password is required";
                      } else {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password: min8caracters(numeric,UpperCase,LowerCase)';
                        } else {
                          return null;
                        }
                      }
                    },
                    onSaved: (value) {
                      password = value.toString();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderradius)),
                        minimumSize: Size(widthButton, heightButton)),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Map<String, dynamic> ap =
                            await uapi.checkloginSocialOut(email);
                        if (ap["action"] == "continue") {
                          int aux = await uapi.loginSocialOut(email, password);
                          if (aux == 200) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (route) => false);
                          }
                        } else if (ap["action"] == "link_auth") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LinkScreen(email, password, "socialout")),
                              (route) => false);
                        } else {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              title: const Text("Fail Login"),
                              content: const Text("Account does not exist"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Ok"),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                      child: Text(
                        'Forget password?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: policyTextSize),
                      ),
                      onTap: () async {
                        final Uri uri =
                            Uri(scheme: 'https', host: 'www.github.com');
                        await launchUrl(uri);
                      }),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: policyTextSize),
                          text: "Don't haven an account? "),
                      TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: policyTextSize),
                          text: "Sign up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed('/signup');
                            }),
                    ]),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const PolicyWidget(),
                ),
              ])),
        ));
  }
}
