class Task {
  String title = "";
  bool completed = false;

  Task(
    this.title,
    this.completed,
  );

  Task.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    completed = json["completed"];
  }
}
