class Chat {
  String id;
  String event_id;
  String creador_id;
  String participant_id;
  Chat(
      {required this.id,
      required this.event_id,
      required this.creador_id,
      required this.participant_id});
  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        event_id = json['event_id'],
        creador_id = json['creador_id'],
        participant_id = json['participant_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'event_id': event_id,
        'creador_id': creador_id,
        'participant_id': participant_id,
      };
}
