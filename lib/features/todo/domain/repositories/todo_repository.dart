import 'package:notes/features/todo/domain/entities/todo_enitity.dart';

abstract class TodoRepository{
  Future<void> addTodo(TodoEntity todo);
  Future<List<TodoEntity>> getAllTodos();
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(int id);
}