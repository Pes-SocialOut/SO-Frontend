class Message {
  String chat_id;
  String created_at;
  String id;
  String sender_id;
  String text;
  Message(
      {required this.chat_id,
      required this.created_at,
      required this.id,
      required this.sender_id,
      required this.text});
  Message.fromJson(Map<String, dynamic> json)
      : chat_id = json['chat_id'],
        created_at = json['created_at'],
        id = json['id'],
        sender_id = json['sender_id'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
        'chat_id': chat_id,
        'created_at': created_at,
        'id': id,
        'sender_id': sender_id,
        'text': text,
      };
}

/*
"chat_id": "b96eaf2d-2639-45ec-a160-b160c2f0893b",
        "created_at": "Sun, 29 May 2022 20:20:46 GMT",
        "id": "e4efd1b4-026e-43df-81b5-f7c77920364a",
        "sender_id": "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f",
        "text": "hola del f01e9aaa-f0a9-42f0-98f3-0011f2c07d74"
 */