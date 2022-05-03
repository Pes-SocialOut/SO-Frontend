import 'package:flutter/material.dart';

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

  List user = [
    {
      "id": "1234",
      "username": "Marta Díaz",
      "profile_img_uri": "assets/gato.jpg",
      "languages": ["catalan", "english"],
      "description": "I really like chess and camping. Take me home.",
      "email": "martadiaz@gmail.com",
      "friend_list": [
        {
          "id": "2345",
          "username": "Miguel de Cervantes",
          "profile_img_uri": "assets/dog.jpg"
        },
        {
          "id": "3456",
          "username": "Garcilaso de la Vega",
          "profile_img_uri": "assets/dog.jpg"
        },
        {
          "id": "4567",
          "username": "Miguel de Unamuno",
          "profile_img_uri": "assets/dog.jpg"
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Profile',
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
          )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(user[0]["profile_img_uri"]),
                ),
              ]),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(user[0]["username"], style: creatorStyle),
                        ),
                      ]),
                      const Divider(indent: 50, endIndent: 50),
                      Row(children: [
                        Container(
                          height: 23.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: (user[0]["languages"].contains("catalan"))
                                ? const DecorationImage(
                                    image: AssetImage('assets/cat.png'),
                                    fit: BoxFit.fill,
                                  )
                                : const DecorationImage(
                                    image: AssetImage('assets/cat.png'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Color.fromARGB(255, 143, 141, 141),
                                        BlendMode.color)),
                          ),
                        ),
                        const Divider(indent: 5, endIndent: 5),
                        Container(
                          height: 23.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              image: (user[0]["languages"].contains("spanish"))
                                  ? const DecorationImage(
                                      image: AssetImage('assets/esp.jpg'),
                                      fit: BoxFit.fill,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage('assets/esp.jpg'),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                          Color.fromARGB(255, 143, 141, 141),
                                          BlendMode.color))),
                        ),
                        const Divider(indent: 5, endIndent: 5),
                        Container(
                          height: 23.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: (user[0]["languages"].contains("english"))
                                ? const DecorationImage(
                                    image: AssetImage('assets/ing.jpg'),
                                    fit: BoxFit.fill,
                                  )
                                : const DecorationImage(
                                    image: AssetImage('assets/ing.jpg'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Color.fromARGB(255, 143, 141, 141),
                                        BlendMode.color)),
                          ),
                        ),
                      ])
                    ])),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width * 0.1,
              child: IconButton(
                icon: const Icon(Icons.edit),
                color: const Color.fromARGB(255, 42, 115, 45),
                onPressed: () {},
              ),
            ),
          ]),
          const Divider(indent: 5, endIndent: 5),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), //apply padding horizontal or vertical only
              child: Text(
                user[0]["description"],
                style: explainStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //const Divider(indent: 5, endIndent: 5),
          Row(children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Text(
                    'LOGROS',
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
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
                    'AMIGOS',
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
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: ListView(children: const <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/crear_evento.png'),
                          ),
                          title: Text('Creador'),
                          subtitle: Text('Has creado un evento'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/crear_evento.png'),
                          ),
                          title: Text('Creador'),
                          subtitle: Text('Has creado un evento'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/crear_evento.png'),
                          ),
                          title: Text('Creador'),
                          subtitle: Text('Has creado un evento'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/crear_evento.png'),
                          ),
                          title: Text('Creador'),
                          subtitle: Text('Has creado un evento'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/crear_evento.png'),
                          ),
                          title: Text('Creador'),
                          subtitle: Text('Has creado un evento'),
                        ),
                      ])),
                ],
              ),
              Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.42,
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
              ]),
              Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: ListView(children: <Widget>[
                        for (var i = 0; i < user[0]["friend_list"].length; i++)
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                  user[0]["friend_list"][i]["profile_img_uri"]),
                            ),
                            title: Text(user[0]["friend_list"][i]["username"]),
                          )
                      ])),
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
