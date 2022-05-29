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
                  const DrawerHeader(
                    child: Text('Settings',
                        style: TextStyle(color: Colors.white, fontSize: 28),
                        textAlign: TextAlign.center),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 102, 150, 171),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Add friend'),
                    onTap: () =>
                        {Navigator.of(context).pushNamed('/edit_profile')},
                  ),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text('Add friend'),
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
                          title: const Text('Change password'),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/change_password')
                          },
                        )
                      : ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: const Text('Change password'),
                          onTap: () => {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: const Text('Change password'),
                                        content: const Text(
                                            'You can not change your password if you do not have a Social Out account'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ]))
                          },
                        ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: () => {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: const Text('Log out'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('CANCEL'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                        child: const Text('YES'),
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
