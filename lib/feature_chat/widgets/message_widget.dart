/*
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:so_frontend/feature_chat/models/message_model.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
    this.chatMessage,
    this.ownMessage,
    {Key? key}) : super(key: key);

  final ChatMessage chatMessage;
  final bool ownMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: ownMessage? Alignment.centerRight:Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: ownMessage?Radius.circular(20):Radius.circular(0),
              topRight: ownMessage?Radius.circular(0):Radius.circular(20),
              bottomLeft: Radius.circular(20), 
              bottomRight: Radius.circular(20)
            ),
          ),
          color: (
            ownMessage
            //?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.onSecondary
            ?HexColor('80ED99'):Colors.white
          ),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  this.chatMessage.messageContent,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    /*
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    */
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/