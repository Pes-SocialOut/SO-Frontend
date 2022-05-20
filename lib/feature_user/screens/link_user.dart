import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';

class LinkScreen extends StatefulWidget {
  final String email;
  final String password;
  final String type;
  final String token;
  const LinkScreen(this.email, this.password, this.type, this.token, {Key? key})
      : super(key: key);
  @override
  LinkScreenState createState() => LinkScreenState();
}

class LinkScreenState extends State<LinkScreen> {
  final formKey = GlobalKey<FormState>();
  final userAPI uapi = userAPI();
  late String verification = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00c8c8c8),
        title: const Text('Link account'),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: ListView(children: <Widget>[
            Image.asset(
              "assets/Banner.png",
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width / 1.5,
            ),
            const SizedBox(height: 50),
            Center(
              child: Text(
                "Email is already registered\n with an associated\n account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                widget.email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (widget.type == 'socialout') codiVerification(),
            //else if(widget.type == 'google'){},
            if (widget.type == 'socialout') linkButton("socialout")
            else if (widget.type == 'google') linkButton("google")
            else if (widget.type == 'facebook') linkButton("facebook"),
            cancelButton(),
          ]),
        ),
      ),
    );
  }

  //CASILLA DE CODIGO DE VERIFICACION
  Widget codiVerification() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Verification Code",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter verification code';
        }
        return null;
      },
      onSaved: (value) {
        verification = value.toString();
      },
    );
  }

  // BOTON PARA CONFIRMAR ENLACE DE CUENTAS
  Widget linkButton(String s) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary,
            onPrimary: Theme.of(context).colorScheme.onSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(200, 40)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            int linkacount = await uapi.linkRegistrerAndLogin(widget.email,
                widget.password, verification, s, widget.token);
            if (linkacount == 200) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            } else {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text("Fail link"),
                  content: const Text(
                    "Account does not exist\nor\nwrong verification code",
                    textAlign: TextAlign.center,
                  ),
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
          'Link account',
          style: TextStyle(
            height: 1.0,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  //CANCELAR PROCEDIMIENTO Y RETORNAR A LOGIN
  Widget cancelButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(200, 40)),
        onPressed: () {
          Navigator.of(context).pushNamed('/login');
        },
        child: const Text(
          'Cancel',
          style: TextStyle(
            height: 1.0,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
