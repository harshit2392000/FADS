class NotificationItem {
  int? id;
  String? title;
  String? description;
  DateTime? timestamp;
  String? type;
  NotificationItem(
      {this.id, this.title, this.description, this.timestamp, this.type});

  NotificationItem.fromJSON(Map<String, dynamic> json) {
    print(json);
    id = json["id"] as int;
    title = json["title"];
    description = json["description"];
    timestamp = DateTime.parse(json["timestamp"]);
    type = json["type"];
  }
}
