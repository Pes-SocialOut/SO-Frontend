import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title: const Text('Edit profile'),
            onTap: () => {Navigator.of(context).pushNamed('/edit_profile')},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Change password'),
            onTap: () => {Navigator.of(context).pushNamed('/change_password')},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Go to chat'),
            onTap: () => {
              print(APICalls().getCurrentUser()),  
              Navigator.of(context).pushNamed('/chat')
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: const Text('Sign off'),
                          content:
                              const Text('Are you sure you want to log out?'),
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
  }
}
