class TodoEntity {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}