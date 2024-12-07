
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/todo/domain/usecases/todo_cruds.dart';
import 'package:notes/features/todo/presentation/bloc/todo_event.dart';
import 'package:notes/features/todo/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{
  final AddTodo addTodo;
  final GetAllTodos getAllTodos;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.addTodo,
    required this.getAllTodos,
    required this.updateTodo,
    required this.deleteTodo,
 }) : super(TodoInitial()) {
    on<LoadTodoEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(LoadTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try{
      final todos = await getAllTodos();
      emit(TodosLoadedState(todos));

    } catch(error){
      emit(TodoError("Failed to load todos: ${error.toString()}"));
    }
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await addTodo(event.todo);
      add(LoadTodoEvent());
    } catch (error) {
      emit(TodoError("Failed to add todo: ${error.toString()}"));
    }
  }

  Future<void> _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await updateTodo(event.todo);
      add(LoadTodoEvent());
    } catch (error) {
      emit(TodoError("Failed to update todo: ${error.toString()}"));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await deleteTodo(event.id);
      add(LoadTodoEvent());
    } catch (error) {
      emit(TodoError("Failed to delete todo: ${error.toString()}"));
    }
  }

 }