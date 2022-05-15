import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String senderID;
  ChatMessage(
    {
      required this.messageContent, 
      required this.senderID
    }
  );
}
