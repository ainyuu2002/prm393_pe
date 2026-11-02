class Task {
  final int? id;
  final String title;
  final String description;
  final bool isDone;
  final String icon;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.icon,
  });

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: (map['id'] as num?)?.toInt(),
        title: map['title']?.toString() ?? '',
        description: map['description']?.toString() ?? '',
        isDone: map['is_done'] == 1 || map['is_done'] == true,
        icon: map['icon']?.toString() ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'is_done': isDone ? 1 : 0,
        'icon': icon,
      };

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    String? icon,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        icon: icon ?? this.icon,
      );

  @override
  String toString() => 'Task(id: $id, title: $title, description: $description, isDone: $isDone, icon: $icon)';
}
