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

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ListChatScreen> createState() => _ListChatScreen();
}

class _ListChatScreen extends State<ListChatScreen> {
  final chatAPI cAPI = chatAPI();

  void getListChat() {
    cAPI.getListChat(APICalls().getCurrentUser());
  }

  void setListChat() {
    getListChat();
  }

  @override
  void initState() {
    //initUser();
    // TODO: implement initState
    setListChat();
    //getEventName().then((value) => print("value: " + value));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
