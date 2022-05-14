import 'dart:core';

import 'package:flutter/material.dart';

import 'package:so_frontend/feature_navigation/screens/profile.dart';
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
                          : (newPassword1Controller.text.length <= 6)
                              ? showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'The password must be at least 6 characters long and contain one number and one of the following symbols =, *, <, > or !.'),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )
                                          ]))
                              : (!newPassword1Controller.text.contains('0') &&
                                      !newPassword1Controller.text
                                          .contains('1') &&
                                      !newPassword1Controller.text
                                          .contains('2') &&
                                      !newPassword1Controller.text
                                          .contains('3') &&
                                      !newPassword1Controller.text
                                          .contains('4') &&
                                      !newPassword1Controller.text
                                          .contains('5') &&
                                      !newPassword1Controller.text
                                          .contains('6') &&
                                      !newPassword1Controller.text
                                          .contains('7') &&
                                      !newPassword1Controller.text
                                          .contains('8') &&
                                      !newPassword1Controller.text
                                          .contains('9'))
                                  ? showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  'The password must be at least 6 characters long and contain one number and one of the following symbols =, *, <, > or !.'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ]))
                                  : (!newPassword1Controller.text
                                              .contains('=') &&
                                          !newPassword1Controller.text
                                              .contains('*') &&
                                          !newPassword1Controller.text
                                              .contains('<') &&
                                          !newPassword1Controller.text
                                              .contains('>') &&
                                          !newPassword1Controller.text
                                              .contains('!'))
                                      ? showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                  title: const Text('Error'),
                                                  content: const Text(
                                                      'The password must be at least 6 characters long and contain one number and one of the following symbols =, *, <, > or !.'),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ]))
                                      : (newPassword2Controller.text ==
                                              newPassword1Controller.text)
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileScreen(
                                                  id: getCurrentUser(),
                                                ),
                                              ))
                                          : showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(title: const Text('Error'), content: const Text('Botch passwords must match'), actions: [
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
