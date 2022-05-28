// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:so_frontend/feature_navigation/widgets/settings.dart';

class ProfileScreen extends StatefulWidget {
  final String id;
  const ProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var creatorStyle =
      const TextStyle(color: Color.fromARGB(255, 17, 92, 153), fontSize: 20);
  var explainStyle =
      const TextStyle(color: Color.fromARGB(255, 61, 60, 60), fontSize: 18);
  var titleStyle = const TextStyle(color: Colors.black, fontSize: 18);

  APICalls ac = APICalls();

  Map user = {};
  String idProfile = '0';

  @override
  void initState() {
    super.initState();
    idProfile = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 16))
              .tr(),
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            iconSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 17, 92, 153)),
        ),
        endDrawer: Settings(id: idProfile),
        body: FutureBuilder(
            future: ac.getItem('v2/users/:0', [idProfile]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                user = json.decode(snapshot.data.body);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(children: [
                    Row(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(children: const [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/dog.jpg"),
                          ),
                        ]),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("${user["username"]}",
                                        style: creatorStyle),
                                    const Divider(indent: 5, endIndent: 5),
                                    Container(
                                        height: 23.0,
                                        width: 25.0,
                                        decoration:
                                            (ac.getCurrentUser() == idProfile)
                                                ? BoxDecoration(
                                                    image: (user["auth_methods"]
                                                            .contains("logo"))
                                                        ? const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/logo.png'),
                                                            fit: BoxFit.fill,
                                                          )
                                                        : const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/logo.png'),
                                                            fit: BoxFit.fill,
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        143,
                                                                        141,
                                                                        141),
                                                                    BlendMode
                                                                        .color)),
                                                  )
                                                : null),
                                    const Divider(indent: 5, endIndent: 5),
                                    Container(
                                        height: 23.0,
                                        width: 25.0,
                                        decoration:
                                            (ac.getCurrentUser() == idProfile)
                                                ? BoxDecoration(
                                                    image: (user["auth_methods"]
                                                            .contains("google"))
                                                        ? const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/google.png'),
                                                            fit: BoxFit.fill,
                                                          )
                                                        : const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/google.png'),
                                                            fit: BoxFit.fill,
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        143,
                                                                        141,
                                                                        141),
                                                                    BlendMode
                                                                        .color)),
                                                  )
                                                : null),
                                    const Divider(indent: 5, endIndent: 5),
                                    Container(
                                        height: 23.0,
                                        width: 25.0,
                                        decoration: (ac.getCurrentUser() ==
                                                idProfile)
                                            ? BoxDecoration(
                                                image: (user["auth_methods"]
                                                        .contains("facebook"))
                                                    ? const DecorationImage(
                                                        image: AssetImage(
                                                            'assets/facebook.png'),
                                                        fit: BoxFit.fill,
                                                      )
                                                    : const DecorationImage(
                                                        image: AssetImage(
                                                            'assets/facebook.png'),
                                                        fit: BoxFit.fill,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Color.fromARGB(
                                                                    255,
                                                                    143,
                                                                    141,
                                                                    141),
                                                                BlendMode
                                                                    .color)),
                                              )
                                            : null),
                                  ],
                                ),
                                const Divider(indent: 50, endIndent: 50),
                                Row(children: [
                                  Container(
                                    height: 23.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      image: (user["languages"]
                                              .contains("catalan"))
                                          ? const DecorationImage(
                                              image:
                                                  AssetImage('assets/cat.png'),
                                              fit: BoxFit.fill,
                                            )
                                          : const DecorationImage(
                                              image:
                                                  AssetImage('assets/cat.png'),
                                              fit: BoxFit.fill,
                                              colorFilter: ColorFilter.mode(
                                                  Color.fromARGB(
                                                      255, 143, 141, 141),
                                                  BlendMode.color)),
                                    ),
                                  ),
                                  const Divider(indent: 5, endIndent: 5),
                                  Container(
                                    height: 23.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        image: (user["languages"]
                                                .contains("spanish"))
                                            ? const DecorationImage(
                                                image: AssetImage(
                                                    'assets/esp.jpg'),
                                                fit: BoxFit.fill,
                                              )
                                            : const DecorationImage(
                                                image: AssetImage(
                                                    'assets/esp.jpg'),
                                                fit: BoxFit.fill,
                                                colorFilter: ColorFilter.mode(
                                                    Color.fromARGB(
                                                        255, 143, 141, 141),
                                                    BlendMode.color))),
                                  ),
                                  const Divider(indent: 5, endIndent: 5),
                                  Container(
                                    height: 23.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      image: (user["languages"]
                                              .contains("english"))
                                          ? const DecorationImage(
                                              image:
                                                  AssetImage('assets/ing.jpg'),
                                              fit: BoxFit.fill,
                                            )
                                          : const DecorationImage(
                                              image:
                                                  AssetImage('assets/ing.jpg'),
                                              fit: BoxFit.fill,
                                              colorFilter: ColorFilter.mode(
                                                  Color.fromARGB(
                                                      255, 143, 141, 141),
                                                  BlendMode.color)),
                                    ),
                                  ),
                                ])
                              ])),
                    ]),
                    const Divider(indent: 5, endIndent: 5),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${user["description"]}",
                          style: explainStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Text(
                              'ACHIEVEMENTS',
                              style: titleStyle,
                              textAlign: TextAlign.center,
                            ).tr(),
                          ),
                        ],
                      ),
                      Column(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ]),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Text(
                              'FRIENDS',
                              style: titleStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ]),
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.47,
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: ListView(children: <Widget>[
                                  for (var i = 0;
                                      i < user["achievements"].length;
                                      i++)
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/achievements/' +
                                                user["achievements"][i]["id"] +
                                                '.png'),
                                      ),
                                      title: Text(
                                          user["achievements"][i]["title"]),
                                      subtitle: Row(
                                        children: <Widget>[
                                          for (var j = 0;
                                              j <
                                                  user["achievements"][i]
                                                      ["progress"];
                                              ++j)
                                            Icon(Icons.brightness_1,
                                                size: 14,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          for (var j = 0;
                                              j <
                                                  user["achievements"][i]
                                                          ["stages"] -
                                                      user["achievements"][i]
                                                          ["progress"];
                                              ++j)
                                            Icon(Icons.brightness_1_outlined,
                                                size: 14,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                        ],
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                    title: Text(
                                                        user["achievements"][i]
                                                            ["title"]),
                                                    content: Text(
                                                        user["achievements"][i]
                                                            ["description"]),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('Ok').tr(),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      )
                                                    ]));
                                      },
                                    ),
                                ])),
                          ],
                        ),
                        Column(children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.47,
                            width: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ]),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.47,
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: (ac.getCurrentUser() == idProfile)
                                  ? ListView(children: <Widget>[
                                      for (var i = 0;
                                          i < user["friends"].length;
                                          i++)
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundImage:
                                                AssetImage("assets/dog.jpg"),
                                          ),
                                          title: Text(
                                              user["friends"][i]["username"]),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileScreen(
                                                    id: user["friends"][i]
                                                        ["id"],
                                                  ),
                                                ));
                                          },
                                        )
                                    ])
                                  : Text('onlyseeyourfriends').tr(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
