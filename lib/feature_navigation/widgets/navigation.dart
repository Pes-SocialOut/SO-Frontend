import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/screens/home.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({ Key? key }) : super(key: key);

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {

  int _index = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    HomeScreen(),
    Text('Create an event')
  ];

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
        title: Text('SocialOut', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.background,
        )),
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Center(child: _widgetOptions.elementAt(_index)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Theme.of(context).colorScheme.primary
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_rounded),
            label: 'Explore',
            backgroundColor: Theme.of(context).colorScheme.primary
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: 'Create',
            backgroundColor: Theme.of(context).colorScheme.primary
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onItemTapped
      ),

    );
  }
}