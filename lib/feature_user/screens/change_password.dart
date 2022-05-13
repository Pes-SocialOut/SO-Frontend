import 'dart:core';

import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  String oldPassword = '';
  String newPassword1 = '';
  String newPassword2 = '';
  bool showPassword = true;

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
            builContainerText("Enter your current password", oldPassword, true),
            builContainerText("Enter your new password", newPassword1, true),
            builContainerText("Repeat your new password", newPassword2, true),
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
                      (oldPassword.isEmpty ||
                              newPassword1.isEmpty ||
                              newPassword2.isEmpty)
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
                          : (newPassword1.length <= 6)
                              ? showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'The password must be at least 6 characters long.'),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )
                                          ]))
                              : (newPassword2 == newPassword1)
                                  ? Navigator.of(context).pushNamed('/profile')
                                  : Navigator.of(context).pushNamed('/profile');
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
