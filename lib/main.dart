import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/dependency_injection.dart';
import 'dependency_injection.dart' as di;
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/bloc/todo_event.dart';
import 'features/todo/presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => di.sl<TodoBloc>()..add(LoadTodoEvent()),
        child: const TodoPage(),
      ),
    );
  }
}
