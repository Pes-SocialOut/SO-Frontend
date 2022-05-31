import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/create_event.dart';
import 'package:so_frontend/feature_explore/screens/home.dart';
import 'package:so_frontend/feature_home/screens/home.dart';
import 'package:so_frontend/feature_navigation/screens/profile.dart';
import 'package:so_frontend/feature_user/services/externalService.dart';
import 'package:so_frontend/utils/go_to.dart';
import 'package:uni_links/uni_links.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:async';
import 'package:so_frontend/feature_event/screens/event_screen.dart';
import 'dart:convert';

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

  String urlProfilePhoto = "";
  final ExternServicePhoto es = ExternServicePhoto();

  Future<void> getProfilePhoto() async {
    final response = await es.getAPhoto(getCurrentUser());
    if (response != 'Fail') {
      setState(() {
        urlProfilePhoto = response;
      });
    }
  }

  StreamSubscription? _sub;

  Future<void> initUniLinks() async {
    // ... check initialLink

    // Attach a listener to the stream
    _sub = linkStream.listen((String? link) async {
      // Parse the link and warn the user, if it is not correct

      if (link != null) {
        // https://socialout-develop.herokuapp.com/v2/events/i
        // https://socialout-develop.herokuapp.com/v2/users/new_friend?code=xxx
        var uri = Uri.parse(link);
        var type = uri.pathSegments[1];
        switch (type) {
          case "events":
            var id = uri.pathSegments[2];
            if (id != '') {
              Navigator.of(context).pushNamed('/home');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventScreen(id: id)));
            }
            break;
          case "users":
            var response = await APICalls().getCollection(
                '/v2/users/new_friend',
                [],
                {"code": uri.queryParameters["code"]!});
            Navigator.of(context).pushNamed('/home');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(id: json.decode(response.body)["id"])));
            break;
          default:
        }
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
    getProfilePhoto();
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
                          child: (urlProfilePhoto == "")
                              ? Image.asset('assets/noProfileImage.png')
                              : Image.network(urlProfilePhoto),
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
                label: 'Home'.tr(),
                backgroundColor: Theme.of(context).colorScheme.primary),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search_rounded),
                label: 'Explore'.tr(),
                backgroundColor: Theme.of(context).colorScheme.primary),
            BottomNavigationBarItem(
                icon: const Icon(Icons.add),
                label: 'Create'.tr(),
                backgroundColor: Theme.of(context).colorScheme.primary),
          ],
          currentIndex: _index,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          onTap: _onItemTapped),
    );
  }
}
