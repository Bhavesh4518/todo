
import 'package:notes/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:notes/features/todo/data/models/todo_model.dart';
import 'package:notes/features/todo/domain/entities/todo_enitity.dart';
import 'package:notes/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository{
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTodo(TodoEntity todo){
    return localDataSource.addTodo(
      TodoModel(title: todo.title, description: todo.description)
    );
  }

  @override
  Future<void> deleteTodo(int id) {
    return localDataSource.deleteTodo(id);
  }

  @override
  Future<List<TodoEntity>> getAllTodos() {
   return localDataSource.getAllTodos();
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    return localDataSource.updateTodo(
      TodoModel(
          id: todo.id,
          title: todo.title,
          description: todo.description
      )
    );
  }}