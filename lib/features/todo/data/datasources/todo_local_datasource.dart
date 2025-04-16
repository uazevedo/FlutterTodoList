import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final List<TodoModel> _todoList = [];

  final Uuid _uuid = const Uuid();

  @override
  Future<List<TodoModel>> getTodos() async {
    return Future.value(List.unmodifiable(_todoList));
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final newTodo = todo.copyWith(id: _uuid.v4());
    _todoList.add(newTodo as TodoModel);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final index = _todoList.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todoList[index] = todo;
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    _todoList.removeWhere((t) => t.id == id);
  }
}
