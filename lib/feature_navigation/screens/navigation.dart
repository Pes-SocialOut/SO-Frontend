import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/create_event.dart';
import 'package:so_frontend/feature_explore/screens/home.dart';
import 'package:so_frontend/feature_home/screens/home.dart';
import 'package:so_frontend/feature_navigation/screens/profile.dart';

import 'package:so_frontend/utils/api_controller.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({Key? key}) : super(key: key);

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int _index = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainHomeScreen(),
    HomeScreen(),
    CreateEventScreen()
  ];

  APICalls ac = APICalls();

  String getCurrentUser() {
    return ac.getCurrentUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: FittedBox(
                    child: Image.asset('assets/logo.png'), fit: BoxFit.fill),
              ),
              const SizedBox(width: 5),
              Text('SocialOut',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  )),
            ],
          ),
          leading: const SizedBox(),
          elevation: 1,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          id: getCurrentUser(),
                        ),
                      ));
                },
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: ClipRRect(
                      child: FittedBox(
                          child: Image.asset('assets/dog.jpg'),
                          fit: BoxFit.fitHeight),
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
            )
          ]),
      body: Center(child: _widgetOptions.elementAt(_index)),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home',
                backgroundColor: Theme.of(context).colorScheme.primary),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search_rounded),
                label: 'Explore',
                backgroundColor: Theme.of(context).colorScheme.primary),
            BottomNavigationBarItem(
                icon: const Icon(Icons.add),
                label: 'Create',
                backgroundColor: Theme.of(context).colorScheme.primary),
          ],
          currentIndex: _index,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          onTap: _onItemTapped),
    );
  }
}
