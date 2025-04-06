class Journal {
  int? id;
  String title;
  String content;
  DateTime date;
  List<String>? imageUrls;

  Journal({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    this.imageUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'imageUrls': imageUrls?.join(','),
    };
  }

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      imageUrls: map['imageUrls']?.split(','),
    );
  }
}
