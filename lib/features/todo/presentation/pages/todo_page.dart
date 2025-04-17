import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste/features/todo/presentation/widgets/todo_card.dart';
import '../controllers/todo_controller.dart';
import '../../domain/entities/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ToDo List")),
      body: BlocBuilder<TodoController, List<TodoEntity>>(
        builder: (context, todos) {
          final sortedTodos = [...todos]
            ..sort((a, b) => a.isDone == b.isDone ? 0 : (a.isDone ? 1 : -1));

          final firstCompletedIndex =
          sortedTodos.indexWhere((todo) => todo.isDone);

          return ListView.builder(
            itemCount: sortedTodos.length + (firstCompletedIndex != -1 ? 1 : 0),
            itemBuilder: (_, index) {
              if (firstCompletedIndex != -1 && index == firstCompletedIndex) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Divider(),
                    ],
                  ),
                );
              }

              final todo = sortedTodos[
              index > firstCompletedIndex && firstCompletedIndex != -1
                  ? index - 1
                  : index];

              return TodoCard(
                todo: todo,
                onEdit: () {
                  _showEditDialog(context, todo);
                },
                onDelete: () {
                  context.read<TodoController>().deleteTodo(todo.id);
                },
                onToggleDone: (value) {
                  context.read<TodoController>().toggleTodo(todo.id);
                },
                color: todo.isDone ? Colors.grey[300] : Colors.white,
                textStyle: todo.isDone
                    ? const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black54,
                )
                    : const TextStyle(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova tarefa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<TodoController>().addTodo(
                titleController.text,
                descriptionController.text,
              );
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, TodoEntity todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar tarefa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<TodoController>().updateTodo(
                todo.copyWith(
                  title: titleController.text,
                  description: descriptionController.text,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }
}