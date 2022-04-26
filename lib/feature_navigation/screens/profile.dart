import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var creatorStyle =
      const TextStyle(color: Color.fromARGB(255, 17, 92, 153), fontSize: 20);
  var explainStyle =
      const TextStyle(color: Color.fromARGB(255, 61, 60, 60), fontSize: 18);
  var titleStyle = const TextStyle(color: Colors.black, fontSize: 18);
  bool cat = true;
  bool spa = true;
  bool eng = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
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
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text('Sergi Gómez', style: creatorStyle),
                        ),
                      ]),
                      const Divider(indent: 50, endIndent: 50),
                      Row(children: [
                        Container(
                          height: 23.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: (cat == false)
                                ? const DecorationImage(
                                    image: AssetImage('assets/cat.png'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Color.fromARGB(255, 143, 141, 141),
                                        BlendMode.color))
                                : const DecorationImage(
                                    image: AssetImage('assets/cat.png'),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        const Divider(indent: 5, endIndent: 5),
                        Container(
                          height: 23.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: (spa == false)
                                ? const DecorationImage(
                                    image: AssetImage('assets/esp.jpg'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Color.fromARGB(255, 143, 141, 141),
                                        BlendMode.color))
                                : const DecorationImage(
                                    image: AssetImage('assets/esp.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        const Divider(indent: 5, endIndent: 5),
                        Container(
                          height: 23.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: (eng == false)
                                ? const DecorationImage(
                                    image: AssetImage('assets/ing.jpg'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Color.fromARGB(255, 143, 141, 141),
                                        BlendMode.color))
                                : const DecorationImage(
                                    image: AssetImage('assets/ing.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ])
                    ])),
          ]),
          const Divider(indent: 5, endIndent: 5),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              ElevatedButton(
                  child: const Text('Ajedrez'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 224, 111, 164),
                  ),
                  onPressed: () {}),
              const Divider(indent: 4, endIndent: 4),
              ElevatedButton(
                  child: const Text('Ajedrez'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 224, 111, 164),
                  ),
                  onPressed: () {}),
              const Divider(indent: 4, endIndent: 4),
              ElevatedButton(
                  child: const Text('Ajedrez'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 224, 111, 164),
                  ),
                  onPressed: () {}),
              const Divider(indent: 4, endIndent: 4),
              ElevatedButton(
                  child: const Text('Ajedrez'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 224, 111, 164),
                  ),
                  onPressed: () {}),
              const Divider(indent: 4, endIndent: 4),
              ElevatedButton(
                  child: const Text('Ajedrez'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 224, 111, 164),
                  ),
                  onPressed: () {}),
              const Divider(indent: 4, endIndent: 4),
            ]),
          ),
          const Divider(indent: 5, endIndent: 5),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), //apply padding horizontal or vertical only
              child: Text(
                'Buenas! Me gustan los torenos de ajedrez y ganar, sobre todo ganar, vamos, que si no gano os pego porque soy el mejor y aquí hay que escribir mucho texto que yo que sé uwuwu.',
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
                      child: ListView(children: const <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/dog.jpg'),
                          ),
                          title: Text('Gabriel Martinez'),
                        ),
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
