import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  var dateStyle = const TextStyle(
      color: Color.fromARGB(255, 18, 111, 187),
      decorationStyle: TextDecorationStyle.wavy,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      height: 1.4);
  var eventStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
      height: 1.4);
  var participantsStyle = const TextStyle(color: Colors.green, fontSize: 18);
  var explainStyle =
      const TextStyle(color: Color.fromARGB(255, 61, 60, 60), fontSize: 18);
  var creatorStyle =
      const TextStyle(color: Color.fromARGB(255, 17, 92, 153), fontSize: 20);
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(children: [
        Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/cat.jpg"),
                ),
            ]),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text('FRI, 4 MAR · 16:00', style: dateStyle),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: Text('Chess Competition at Tetuan',
                      style: eventStyle, textAlign: TextAlign.left),
                ),
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('MODERATE'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 230, 217, 106),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: const Text('Contaminación moderada'),
                                    content: const Text(
                                        'Se espera que para la fecha y hora indicados en el evento la polución sea moderada.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Aceptar'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ]));
                      },
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    Row(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          const Icon(
                            Icons.person,
                            color: Colors.green,
                            size: 30.0,
                          ),
                          Text('17/20', style: participantsStyle)
                        ]),
                      ),
                    ]),
                  ])
            ]),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Created by: Mark     ',
            style: creatorStyle,
            textAlign: TextAlign.center,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/dog.jpg"),
          )
        ]),
        const Divider(
            color: Color.fromARGB(255, 53, 52, 52),
            height: 30,
            indent: 30,
            endIndent: 30),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), //apply padding horizontal or vertical only
            child: Text(
              'Hello everybody! If you like chess as much as I do, you have to come to this open-air tournament in Tetuan square in Barcelona. There will be drinks and food until one of us wins. Dont miss this opportunity and sign up now!',
              style: explainStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ]),
        const Divider(indent: 50, endIndent: 50),
        Row(mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.share,
                      size: 30.0, color: Color.fromARGB(255, 110, 108, 108)),
                  onPressed: () {}),
              const Divider(endIndent: 30),
              ElevatedButton(
                child: const Text('    JOIN NOW    '),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: const Text('Joined!'),
                              content: const Text(
                                  'You have joined the event! Now you will recieve notifications about it.\nYou can change this on settings.'),
                              actions: [
                                TextButton(
                                  child: const Text('Aceptar'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ]));
                },
              ),
              const Divider(indent: 30),
              IconButton(
                  icon: Icon(Icons.favorite,
                      size: 30.0,
                      color: (isFavourite == true)
                          ? Colors.red
                          : const Color.fromARGB(255, 114, 113, 113)),
                  onPressed: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  })
            ]),
      ]),
    );
  }
}
