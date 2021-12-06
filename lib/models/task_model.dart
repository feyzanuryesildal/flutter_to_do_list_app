class Task {
  late int id;
  late String title;
  late DateTime date;
  late String priority;
  late int status;

  Task({required this.title, required this.date, required this.priority});
  Task.withId(
      {required this.id,
      required this.title,
      required this.date,
      required this.priority,
      required this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date;
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
        id: map['id'],
        title: map['title'],
        date: map['date'],
        priority: map['priority'],
        status: map['status']);
  }
}
