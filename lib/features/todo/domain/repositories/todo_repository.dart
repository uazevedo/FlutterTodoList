import '../entities/todo.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> toggleTodo(String id);
  Future<void> deleteTodo(String id);
  Future<void> updateTodo(TodoEntity todo);
}
