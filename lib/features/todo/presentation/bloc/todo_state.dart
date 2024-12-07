import 'package:notes/features/todo/domain/entities/todo_enitity.dart';

abstract class TodoState{}

class TodoInitial extends TodoState{}
class TodoLoading extends TodoState{}

class TodosLoadedState extends TodoState{
  final List<TodoEntity> todos;

  TodosLoadedState(this.todos);
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}