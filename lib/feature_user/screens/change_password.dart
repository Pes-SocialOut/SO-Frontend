import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:so_frontend/utils/api_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPassword1Controller = TextEditingController();
  TextEditingController newPassword2Controller = TextEditingController();

  bool showPassword = true;

  APICalls ac = APICalls();

  String getCurrentUser() {
    return ac.getCurrentUser();
  }

  bool pass = false;
  void postPassword(String idProfile) async {
    final response = await ac.getItem("/v1/users/:0/pw", [idProfile]);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      pass = true;
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];
      ac.initialize(userID, accessToken, refreshToken, true);
    } else if (response.statusCode == 400) {
      pass = false;
    }
  }

  bool correctChange() {
    postPassword(getCurrentUser());
    return pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change password',
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(left: 30),
                  labelText: 'Enter your current password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(29),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: newPassword1Controller,
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(left: 30),
                  labelText: 'Enter your new password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(29),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: newPassword2Controller,
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(left: 30),
                  labelText: 'Repeat your new password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(29),
                    ),
                  ),
                ),
              ),
            ),
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
                      (oldPasswordController.text.isEmpty ||
                              newPassword1Controller.text.isEmpty ||
                              newPassword2Controller.text.isEmpty)
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'All fields are required.'),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ]))
                          : (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                  .hasMatch(newPassword1Controller.text))
                              ? showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'Enter valid password: min8caracters(numeric,UpperCase,LowerCase)'),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )
                                          ]))
                              : (newPassword1Controller.text !=
                                      newPassword2Controller.text)
                                  ? showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  'Botch passwords must match'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ]))
                                  : (!correctChange())
                                      ? showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                  title: const Text('Error'),
                                                  content: const Text(
                                                      'Incorrect old password'),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ]))
                                      : showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                  title: const Text('Correct'),
                                                  content: const Text(
                                                      'Password changed correctly'),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ]));
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
}

//(ac.postItem('v2/users/:0/pw', [getCurrentUser()], {"old": oldPasswordController.text, "new": newPassword1Controller.text}));