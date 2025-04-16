import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  final List<TodoEntity> _todos = [];

  @override
  Future<List<TodoEntity>> getTodos() async {
    return List.unmodifiable(_todos);
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    _todos.add(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
  }

  @override
  Future<void> toggleTodo(String id) async {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(isDone: !_todos[index].isDone);
    }
  }

  @override
  Future<void> updateTodo(TodoEntity updatedTodo) async {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }
}