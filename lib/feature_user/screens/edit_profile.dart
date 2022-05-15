import 'dart:core';

import 'package:flutter/material.dart';

class EditarProfile extends StatefulWidget {
  const EditarProfile({Key? key}) : super(key: key);

  @override
  State<EditarProfile> createState() => _EditarProfileState();
}

class _EditarProfileState extends State<EditarProfile> {
  String username = "niceCat";
  String password = "fibupc";
  String description = "description_cat";
  String languages = "catalán";
  String hobbies = "miau miau";
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile',
            style: TextStyle(
                color: Theme.of(context).colorScheme.surface, fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          iconSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 4.0,
                        style: BorderStyle.solid,
                      ),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.6),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/cat.jpg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      iconSize: 24,
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
                      onPressed: () {
                        // editar foto de perfil
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            builContainerText("Username", username, false),
            builContainerText("Password", password, true),
            builContainerText("description", description, false),
            builContainerText("languages", languages, false),
            builContainerText("hobbies", hobbies, false),
            const SizedBox(height: 15),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(200, 40),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/welcome');
                      // retornar a home de usuario
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container builContainerText(
      String labelText2, String placeHolder, bool isPasswordTextField) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: isPasswordTextField ? showPassword : false,
        initialValue: placeHolder,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(left: 30),
          labelText: labelText2,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(29),
            ),
          ),
        ),
      ),
    );
  }
}
