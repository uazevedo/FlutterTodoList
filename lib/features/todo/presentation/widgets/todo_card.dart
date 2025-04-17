import 'package:flutter/material.dart';
import '../../domain/entities/todo.dart';

class TodoCard extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggleDone;
  final Color? color;
  final TextStyle? textStyle;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleDone,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) => onToggleDone(value!),
        ),
        title: Text(todo.title, style: textStyle),
        subtitle: Text(todo.description, style: textStyle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}