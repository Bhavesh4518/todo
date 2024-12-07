import 'package:notes/features/todo/domain/entities/todo_enitity.dart';

abstract class TodoEvent {}

class LoadTodoEvent extends TodoEvent{}

class AddTodoEvent extends TodoEvent{
  final TodoEntity todo;

  AddTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;

  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent(this.id);
}