import 'package:notes/features/todo/domain/entities/todo_enitity.dart';
import 'package:notes/features/todo/domain/repositories/todo_repository.dart';

class AddTodo{
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<void> call(TodoEntity todo){
    return repository.addTodo(todo);
  }
}

class GetAllTodos{
  final TodoRepository repository;

  GetAllTodos(this.repository);

  Future<List<TodoEntity>> call(){
    return repository.getAllTodos();
  }
}

class UpdateTodo{
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<void> call(TodoEntity todo){
    return repository.updateTodo(todo);
  }
}

class DeleteTodo{
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> call(int id){
    return repository.deleteTodo(id);
  }
}
