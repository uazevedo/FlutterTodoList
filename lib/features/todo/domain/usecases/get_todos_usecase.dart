import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosUsecase {
  final TodoRepository repository;

  GetTodosUsecase(this.repository);

  Future<List<TodoEntity>> call() {
    return repository.getTodos();
  }
}
