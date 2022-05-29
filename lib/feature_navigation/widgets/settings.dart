// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/utils/share.dart';
import 'dart:convert';

class Settings extends StatefulWidget {
  final String id;
  const Settings({Key? key, required this.id}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  APICalls ac = APICalls();

  String getCurrentUser() {
    return ac.getCurrentUser();
  }

  Map url = {};
  Map user = {};
  String idProfile = '0';

  @override
  void initState() {
    super.initState();
    idProfile = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ac.getItem('v2/users/:0', [idProfile]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            user = json.decode(snapshot.data.body);
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('Settings',
                            style: TextStyle(color: Colors.white, fontSize: 28),
                            textAlign: TextAlign.center)
                        .tr(),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 102, 150, 171),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: Text('editprofile').tr(),
                    onTap: () =>
                        {Navigator.of(context).pushNamed('/edit_profile')},
                  ),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: Text('Add friend'),
                    onTap: () async {
                      final response =
                          await ac.getItem('v2/users/friend_link', []);
                      url = json.decode(response.body);
                      showShareMenuFriend(url['invite_link'], context);
                    },
                  ),
                  (user["auth_methods"].contains("socialout"))
                      ? ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: Text('Changepassword').tr(),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/change_password')
                          },
                        )
                      : ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: Text('Changepassword').tr(),
                          onTap: () => {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: Text('Change password').tr(),
                                        content: Text('notchangepassword').tr(),
                                        actions: [
                                          TextButton(
                                            child: Text('Ok').tr(),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ]))
                          },
                        ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text('Logout').tr(),
                    onTap: () => {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: const Text('Log out'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel').tr(),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                        child: Text('Yes').tr(),
                                        onPressed: () => APICalls().logOut())
                                  ]))
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
