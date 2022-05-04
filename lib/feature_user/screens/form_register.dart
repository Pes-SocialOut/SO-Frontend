import 'package:flutter/material.dart';

class FormRegister extends StatefulWidget {
  final String email;
  final String password;
  const FormRegister(this.email, this.password, {Key? key}) : super(key: key);
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final formKey = GlobalKey<FormState>();

  late String username;
  late String description;
  late String languages;
  late String hobbies;
  late String verification;

  Widget _buildUsername() {
    return TextFormField(
      initialValue: widget.email,
      decoration: const InputDecoration(
        labelText: "Username",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some Username';
        }
        return null;
      },
      onSaved: (value) {
        username = value.toString();
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Description",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some Description';
        }
        return null;
      },
      onSaved: (value) {
        description = value.toString();
      },
    );
  }

  Widget _buildLanguages() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "preferred languages",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some language';
        }
        return null;
      },
      onSaved: (value) {
        languages = value.toString();
      },
    );
  }

  Widget _buildHobbies() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "hobbies",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some hobbie';
        }
        return null;
      },
      onSaved: (value) {
        hobbies = value.toString();
      },
    );
  }

  Widget _buildVerification() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User register"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 25),
                _buildUsername(),
                const SizedBox(height: 15),
                _buildDescription(),
                const SizedBox(height: 15),
                _buildLanguages(),
                const SizedBox(height: 15),
                _buildHobbies(),
                const SizedBox(height: 15),
                _buildVerification(),
                const SizedBox(height: 25),

                // Button submit
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(250, 50)),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      }
                      Navigator.of(context).pushNamed('/edit_profile');
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                //button cancelar
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xC8C8C8),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(150, 50)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: const Text("cancel subscription"),
                          content:
                              const Text("want to cancel the subscription?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed('/welcome'),
                                child: const Text("Ok")),
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("cancel")),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'cancelar',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
