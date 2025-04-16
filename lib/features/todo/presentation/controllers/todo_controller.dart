import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoController extends Cubit<List<TodoEntity>> {
  final TodoRepository repository;

  TodoController(this.repository) : super([]);

  Future<void> loadTodos() async {
    final todos = await repository.getTodos();
    emit(todos);
  }

  Future<void> toggleTodo(String id) async {
    await repository.toggleTodo(id);
    await loadTodos();
  }

  Future<void> addTodo(String title, String description) async {
    final todo = TodoEntity(id: DateTime.now().toString(), title: title, description: description);
    await repository.addTodo(todo);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await repository.deleteTodo(id);
    await loadTodos();
  }

  Future<void> updateTodo(TodoEntity updatedTodo) async {
    await repository.updateTodo(updatedTodo);
    await loadTodos();
  }

}
