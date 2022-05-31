import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_chat/models/message_model.dart';
import 'package:so_frontend/feature_chat/services/chat_service.dart';
import 'package:so_frontend/feature_chat/widgets/chat_widget.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/feature_user/services/externalService.dart';

class ChatScreen extends StatefulWidget {
  final String eventId;
  final String participanId;
  const ChatScreen(
      {Key? key, required this.eventId, required this.participanId})
      : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  late String _now;
  late Timer _timer;
  final chatAPI cAPI = chatAPI();
  APICalls api = APICalls();
  DateTime _lastQuitTime = DateTime.now();
  final messageTextController = TextEditingController();
  String eventsName = "";
  String linkImageEvent = "";
  String user_creator = "";
  String shownUsername = "";
  String otherId = "";
  Map user = {};

  String urlPhotoMine = "";
  String urlPhotoOther = "";
  final ExternServicePhoto es = ExternServicePhoto();

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

  Future<List> getShownUsername() async {
    final response = await http
        .get(Uri.parse("https://socialout-develop.herokuapp.com/v1/users/"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return [];
  }

  Future<String> getUsername(String idEventCreator) async {
    final response = await api.getItem("/v2/users/:0", [idEventCreator]);
    String username = json.decode(response.body)["username"];

    print(json.decode(response.body));
    return username;
  }

  void initShownUsername() async {
    String idEventCreator = await getEventCreator();
    var pid = widget.participanId;
    var acu = api.getCurrentUser();
    //print("widget.participanId: " + pid);
    //print("api.getCurrentUser(): " + acu);
    bool test = acu.compareTo(pid) == 0;
    //print("bool:" + test.toString());
    if (acu.compareTo(idEventCreator) == 0) {
      //muestra creador del evento
      //print("object1");
      //print("igual:" + shownUsername);

      otherId = widget.participanId;
      print("object1: " + otherId);
      shownUsername = await getUsername(otherId);
      //print("igual:" + shownUsername);
    } else {
      otherId = idEventCreator;
      print("object2: " + otherId);
      shownUsername = await getUsername(otherId);
      //print("no igual:" + shownUsername);
    }
  }

  Future<String> getOtherId() async {
    String idEventCreator = await getEventCreator();
    var pid = widget.participanId;
    var acu = api.getCurrentUser();
    bool test = acu.compareTo(pid) == 0;
    if (acu.compareTo(idEventCreator) == 0) {
      return (widget.participanId);
    } else {
      return (idEventCreator);
    }
  }

  Future<String> getAllMessages(String idEventCreator) async {
    final response = await api.getItem("/v2/users/:0", [idEventCreator]);
    String username = json.decode(response.body)["username"];

    print(json.decode(response.body));
    return username;
  }

  void initAllMessages() async {
    String idEventCreator = await getEventCreator();
    var pid = widget.participanId;
    var acu = api.getCurrentUser();
    bool test = acu.compareTo(pid) == 0;
    if (acu.compareTo(idEventCreator) == 0) {
      shownUsername = await getUsername(pid);
    } else {
      shownUsername = await getUsername(idEventCreator);
    }
    cAPI.openSession(widget.eventId, "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f");
  }

  Future<void> getProfilePhotoMine() async {
    final response = await es.getAPhoto(APICalls().getCurrentUser());

    if (response != 'Fail') {
      urlPhotoMine = response;
    }
  }

  Future<void> getProfilePhotoOther() async {
    print("otherId: " + otherId);
    String other = await getOtherId();
    print("other: " + other);
    final response = await es.getAPhoto(other);
    print("response1: " + response);
    if (response != 'Fail') {
      print("responseURI: " + response);
      urlPhotoOther = response;
    }
  }

  Future<String> getURIProfilePhotoOther(String s) async {
    print("otherId: " + otherId);
    String other = await getOtherId();
    print("other: " + other);
    final response = await es.getAPhoto(other);
    print("response1: " + response);
    if (response != 'Fail') {
      print("responseURI: " + response);
      urlPhotoOther = response;
    }
    return urlPhotoOther;
  }

  @override
  void initState() {
    super.initState();
    getProfilePhotoMine();
    //initUser();
    // TODO: implement initState
    initShownUsername();
    initEventName();
    initEventIcon();
    initEventCreador();
    initAllMessages();
    _now = DateTime.now().second.toString();
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
      });
    });

    print("aqui");
    getProfilePhotoOther();
    //getEventName().then((value) => print("value: " + value));
  }

  @override
  Widget build(BuildContext context) {
    //print("eventname:" + eventsName);
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
            return FutureBuilder(
                future: getOtherId(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    String uriOther = snapshot.data;
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
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                FutureBuilder(
                                    future: getURIProfilePhotoOther(uriOther),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        String a = "1";
                                        String uriOther = snapshot.data;

                                        return ClipOval(
                                          child: SizedBox(
                                            width: 36,
                                            height: 36,
                                            child: ClipRRect(
                                                child: FittedBox(
                                                    child: (uriOther == "")
                                                        ? Image.asset(
                                                            'assets/noProfileImage.png')
                                                        : Image.network(
                                                            uriOther),
                                                    fit: BoxFit.fitHeight),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(
                                          child: CircularProgressIndicator(),
                                          height: 10.0,
                                          width: 10.0,
                                        );
                                      }
                                    }),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FutureBuilder(
                                          future: getEventName(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              eventsName = snapshot.data;
                                              return Text(
                                                eventsName,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              );
                                            } else {
                                              return SizedBox(
                                                child:
                                                    CircularProgressIndicator(),
                                                height: 10.0,
                                                width: 10.0,
                                              );
                                            }
                                          }),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      FutureBuilder(
                                          future: api.getItem('v2/users/:0',
                                              [widget.participanId]),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              user = json
                                                  .decode(snapshot.data.body);
                                              return Text(
                                                shownUsername,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                    fontSize: 13),
                                              );
                                            } else {
                                              return SizedBox(
                                                child:
                                                    CircularProgressIndicator(),
                                                height: 10.0,
                                                width: 10.0,
                                              );
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: Container(
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
                                bool messageMine =
                                    chatMessage[index].sender_id ==
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
                                            SizedBox(
                                              width: 36,
                                              height: 36,
                                              child: ClipRRect(
                                                  child: FittedBox(
                                                      child: (urlPhotoOther ==
                                                              "")
                                                          ? Image.asset(
                                                              'assets/noProfileImage.png')
                                                          : Image.network(
                                                              urlPhotoOther),
                                                      fit: BoxFit.fitHeight),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
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
                                            SizedBox(
                                              width: 36,
                                              height: 36,
                                              child: ClipRRect(
                                                  child: FittedBox(
                                                      child: (urlPhotoMine ==
                                                              "")
                                                          ? Image.asset(
                                                              'assets/noProfileImage.png')
                                                          : Image.network(
                                                              urlPhotoMine),
                                                      fit: BoxFit.fitHeight),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
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
                              padding: EdgeInsets.only(
                                  left: 10, bottom: 10, top: 10),
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
                                      print("currentUserId: " + currentUserId);
                                      print(
                                          "widget.eventId: " + widget.eventId);
                                      print("messageTextController.text:" +
                                          messageTextController.text);
                                      if (messageTextController
                                          .text.isNotEmpty) {
                                        Response resp = await cAPI.createMessage(
                                            widget.participanId,
                                            widget.eventId, //"23fa941a-9bee-4788-8b3d-3ebaa886bfe7",
                                            messageTextController.text);
                                        messageTextController.clear();

                                        setState(() {});
                                      }

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
                    );
                  } else {
                    return Center(
                        child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 30.0,
                      width: 30.0,
                    ));
                  }
                });
          } else {
            return Center(
                child: SizedBox(
              child: CircularProgressIndicator(),
              height: 30.0,
              width: 30.0,
            ));
          }
        });
  }
}
