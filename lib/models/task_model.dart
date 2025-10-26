
enum Priority { low, medium, high }

class Task {
  final String id;
  String title;
  bool isCompleted;
  Priority priority;
  List<String> tags;
  DateTime? date;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.priority = Priority.low,
    this.tags = const [],
    this.date,
  });
}