class AttendeesModel {
  String attendeeId;
  String userId;
  String eventId;

  AttendeesModel({
    required this.attendeeId,
    required this.userId,
    required this.eventId,
  });

  AttendeesModel.fromJson(Map<String, dynamic> json)
      : attendeeId = json['attendeeId'],
        userId = json['userId'],
        eventId = json['eventId'];

  Map<String, dynamic> toJson() {
    return {
      'attendeeId': attendeeId,
      'userId': userId,
      'eventId': eventId,
    };
  }
}
