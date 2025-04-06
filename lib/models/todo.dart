class Todo {
  int? id;
  String title;
  String? details;
  DateTime deadline;
  bool isCompleted;
  int order;

  Todo({
    this.id,
    required this.title,
    this.details,
    required this.deadline,
    this.isCompleted = false,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'order': order,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      details: map['details'],
      deadline: DateTime.parse(map['deadline']),
      isCompleted: map['isCompleted'] == 1,
      order: map['order'],
    );
  }
}
