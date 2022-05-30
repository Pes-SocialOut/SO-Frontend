import 'package:flutter/cupertino.dart';

class ChatMessage {
  String messageContent;
  String senderID;
  ChatMessage({required this.messageContent, required this.senderID});
}

class Message {
  String messageContent;
  String senderID;
  Message({required this.messageContent, required this.senderID});
}

/*
"chat_id": "b96eaf2d-2639-45ec-a160-b160c2f0893b",
        "created_at": "Sun, 29 May 2022 20:20:46 GMT",
        "id": "e4efd1b4-026e-43df-81b5-f7c77920364a",
        "sender_id": "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f",
        "text": "hola del f01e9aaa-f0a9-42f0-98f3-0011f2c07d74"
 */