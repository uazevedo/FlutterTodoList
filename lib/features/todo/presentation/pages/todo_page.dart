import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste/features/todo/presentation/widgets/todo_card.dart';
import '../controllers/todo_controller.dart';
import '../../domain/entities/todo.dart';
import '../../data/repositories_impl/todo_repository_mock.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoController(TodoRepositoryMock())..loadTodos(),
      child: Scaffold(
        appBar: AppBar(title: const Text("ToDo List")),
        body: BlocBuilder<TodoController, List<TodoEntity>>(
          builder: (context, todos) {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (_, index) {
                final todo = todos[index];
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
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova tarefa"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              context.read<TodoController>().addTodo(controller.text, controller.text);
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, TodoEntity todo) {
    final controller = TextEditingController(text: todo.title);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar tarefa"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              context.read<TodoController>().updateTodo(
                todo.copyWith(title: controller.text, description: controller.text),
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
