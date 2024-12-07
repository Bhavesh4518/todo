
import 'package:get_it/get_it.dart';

import 'features/todo/data/datasources/todo_local_data_source.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/todo_cruds.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data Sources
  sl.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSource());

  // Repositories
  sl.registerLazySingleton<TodoRepository>(
          () => TodoRepositoryImpl(localDataSource: sl()));

  // Use Cases
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => GetAllTodos(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // Bloc
  sl.registerFactory(() => TodoBloc(
    addTodo: sl(),
    getAllTodos: sl(),
    updateTodo: sl(),
    deleteTodo: sl(),
  ));
}
