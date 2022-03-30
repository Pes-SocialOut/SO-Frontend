class EventJSON {
  List<Events>? events;

  EventJSON({this.events});

  EventJSON.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? id;
  String? name;
  String? description;
  String? dateCreated;
  String? dateEnd;
  String? userCreator;
  double? longitud;
  double? latitude;
  int? maxParticipants;

  Events(
      {this.id,
      this.name,
      this.description,
      this.dateCreated,
      this.dateEnd,
      this.userCreator,
      this.longitud,
      this.latitude,
      this.maxParticipants});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    dateCreated = json['dateCreated'];
    dateEnd = json['dateEnd'];
    userCreator = json['userCreator'];
    longitud = json['longitud'];
    latitude = json['latitude'];
    maxParticipants = json['max_participants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['dateCreated'] = dateCreated;
    data['dateEnd'] = dateEnd;
    data['userCreator'] = userCreator;
    data['longitud'] = longitud;
    data['latitude'] = latitude;
    data['max_participants'] = maxParticipants;
    return data;
  }
}