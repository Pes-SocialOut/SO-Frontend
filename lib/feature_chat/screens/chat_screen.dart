import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_chat/data_local/data.dart';
import 'package:so_frontend/feature_chat/models/chatMessage.dart';
import 'package:so_frontend/feature_chat/services/chat_service.dart';
import 'package:so_frontend/feature_chat/widgets/chat_widget.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/utils/api_controller.dart';

class ChatScreen extends StatefulWidget {
  final String eventId;
  final String participanId;
  ChatScreen({Key? key, required this.eventId, required this.participanId})
      : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final chatAPI cAPI = chatAPI();
  APICalls api = APICalls();
  DateTime _lastQuitTime = DateTime.now();
  final messageTextController = TextEditingController();
  String eventsName = "";
  String linkImageEvent = "";
  String user_creator = "";
  Map user = {};
  Future<http.Response> getEventItem(
      String endpoint, List<String> pathParams) async {
    final uri = api.buildUri(endpoint, pathParams, null);
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer ' + APICalls().getCurrentAccess(),
      'Content-Type': 'application/json'
    });

    return response;
  }

  Future<String> getEventName() async {
    Response resp = await getEventItem('/v2/events/:0', [widget.eventId]);
    var _event = [json.decode(resp.body)];
    var eventName = _event[0]["name"];
    eventsName = eventName;
    return eventName;
  }

  void initEventName() async {
    eventsName = await getEventName();
  }

  Future<String> getEventIcon() async {
    Response resp = await getEventItem('/v2/events/:0', [widget.eventId]);
    var _event = [json.decode(resp.body)];
    var linkImage = _event[0]["event_image_uri"];

    return linkImage;
  }

  void initEventIcon() async {
    linkImageEvent = await getEventIcon();
  }

  Future<String> getEventCreator() async {
    Response resp = await getEventItem('/v2/events/:0', [widget.eventId]);
    var _event = [json.decode(resp.body)];
    user_creator = _event[0]["user_creator"];

    return user_creator;
  }

  void initEventCreador() async {
    linkImageEvent = await getEventCreator();
  }

  Future<List> getUser() async {
    final response = await http
        .get(Uri.parse("https://socialout-develop.herokuapp.com/v1/users/"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return [];
  }

  void initUser() async {
    //String otherUser = cAPI.he
    await getUser();
  }

  @override
  void initState() {
    //initUser();
    // TODO: implement initState
    initEventName();
    initEventIcon();
    initEventCreador();
    //getEventName().then((value) => print("value: " + value));
  }

  @override
  Widget build(BuildContext context) {
    print("eventname:" + eventsName);
    return FutureBuilder(
        //future: api.getItem('/v2/events/:0', [eventId]),
        future: cAPI.openSession(widget.eventId, widget.participanId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var msg = json.decode(snapshot.data.body);
            //List<Message> message = json.decode(snapshot.data.body);
            List<Message> chatMessage =
                List<Message>.from(msg.map((data) => Message.fromJson(data)));
            chatMessage = chatMessage.reversed.toList();
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.grey,
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(right: 16),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            final difference =
                                DateTime.now().difference(_lastQuitTime);
                            final isExitWarning =
                                difference >= Duration(seconds: 2);

                            _lastQuitTime = DateTime.now();

                            if (isExitWarning) {
                              final message = 'Press back again to quit chat';
                              print('Press back again to exit');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(25), // Image radius
                            child: Image.network(linkImageEvent,
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                eventsName,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              FutureBuilder(
                                  future: api.getItem(
                                      'v2/users/:0', [widget.participanId]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      user = json.decode(snapshot.data.body);
                                      return Text(
                                        "${user["username"]}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            fontSize: 13),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Container(
                child: WillPopScope(
                    onWillPop: () async {
                      final difference =
                          DateTime.now().difference(_lastQuitTime);
                      final isExitWarning = difference >= Duration(seconds: 2);

                      _lastQuitTime = DateTime.now();

                      if (isExitWarning) {
                        final message = 'Press back again to quit chat';
                        print('Press back again to exit');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                        return false;
                      } else {
                        return true;
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          child: ListView.builder(
                            reverse: true,
                            itemCount: chatMessage.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, bottom: 70),
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              //for each message
                              double paddingSelf = 30;
                              double paddingOther = 10;
                              //hardcode
                              bool messageMine = chatMessage[index].sender_id ==
                                  api.getCurrentUser();
                              return Container(
                                //icon+message
                                alignment: messageMine
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                    left: messageMine
                                        ? paddingSelf
                                        : paddingOther,
                                    right: messageMine
                                        ? paddingOther
                                        : paddingSelf,
                                    top: 10,
                                    bottom: 10),
                                child: Align(
                                    alignment: (messageMine
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                    child: Row(
                                      mainAxisAlignment: messageMine
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: <Widget>[
                                        if (!messageMine)
                                          CircleAvatar(
                                            backgroundImage:
                                                AssetImage('assets/gato.jpg')
                                                    as ImageProvider,
                                            //sender's icon
                                            maxRadius: 20,
                                          ),
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: messageMine
                                                      ? Radius.circular(20)
                                                      : Radius.circular(0),
                                                  topRight: messageMine
                                                      ? Radius.circular(0)
                                                      : Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight: Radius.circular(
                                                      20)), //BorderRadius.circular(20),
                                              color: (messageMine
                                                  //?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.onSecondary
                                                  ? HexColor('80ED99')
                                                  : Colors.white),
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Text(
                                              chatMessage[index].text,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        if (messageMine)
                                          CircleAvatar(
                                            backgroundImage:
                                                AssetImage('assets/dog.jpg')
                                                    as ImageProvider,
                                            //user's icon
                                            //backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                                            maxRadius: 20,
                                          ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            height: 60,
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: messageTextController,
                                    decoration: InputDecoration(
                                        hintText: "Write message...",
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        border: InputBorder.none),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                FloatingActionButton(
                                  onPressed: () async {
                                    APICalls api = APICalls();

                                    String currentUserId =
                                        APICalls().getCurrentUser();
                                    String accessToken =
                                        APICalls().getCurrentAccess();
                                    cAPI.getEvents(currentUserId);

                                    print("accessToken:" + accessToken);
                                    print(messageTextController.text);

                                    Response resp = await cAPI.createMessage(
                                        currentUserId,
                                        widget
                                            .eventId, //"23fa941a-9bee-4788-8b3d-3ebaa886bfe7",
                                        messageTextController.text);
                                    messageTextController.clear();
                                    setState(() {});
                                    /*
                //ejecutar cuando unir un participante
                Response resp = await cAPI.createChat(
                    "eventId", currentUserId);
          */
                                    /*
                cAPI.createMessage(
                    "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f",
                    eventId, //"23fa941a-9bee-4788-8b3d-3ebaa886bfe7",
                    "hola del f01e9aaa-f0a9-42f0-98f3-0011f2c07d74");
                    */
                                    /*
                cAPI.enterChat(eventId,
                    "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f");
                */
                                    /*
                cAPI.openSession(eventId,
                    "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f");
                 */
                                    /*
                cAPI.getListChat("fee03319-2742-4ef5-8317-677cb6445eda");
                */
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 18,
                                  ),
                                  backgroundColor: Colors.blue,
                                  elevation: 0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
