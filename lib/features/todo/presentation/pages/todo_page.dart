
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:notes/features/todo/presentation/bloc/todo_event.dart';
import 'package:notes/features/todo/presentation/bloc/todo_state.dart';

import '../../domain/entities/todo_enitity.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  void addTodoSheet(BuildContext context, {TodoEntity? todo}) {
    final todoBloc = context.read<TodoBloc>(); // Ensure access to TodoBloc
    showModalBottomSheet(
      context: context,

      isScrollControlled: true,
      builder: (context) => AddTodoForm(todo: todo, todoBloc: todoBloc),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodoSheet(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<TodoBloc,TodoState>(
              builder:(context,state){
                if(state is TodoLoading){
                  return const Center(child: CircularProgressIndicator());
                } else if(state is TodosLoadedState){
                  if(state.todos.isEmpty){
                    return const Center(child: Text('No todos available.'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (context,index){
                      final todo = state.todos[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                            color: Colors.grey.shade200),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        child: ListTile(
                          title: Text(todo.title),
                          subtitle: Text(todo.description),
                          trailing:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  addTodoSheet(context,todo: todo);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context
                                      .read<TodoBloc>()
                                      .add(DeleteTodoEvent(todo.id!));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if(state is TodoError){
                  return Center(child: Text(state.message));
                } else{
                  return const SizedBox.shrink();
                }
              }
          ),
        ),
      ),
    );
  }
}


class AddTodoForm extends StatefulWidget {
  final TodoEntity? todo;
  final TodoBloc todoBloc;

  const AddTodoForm({
    Key? key,
    this.todo,
    required this.todoBloc,
  }) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.todo?.title ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.todo?.description ?? '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo != null;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEditing ? 'Edit Todo' : 'Add Todo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isEmpty || description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fields cannot be empty')),
                  );
                  return;
                }

                if (isEditing) {
                  widget.todoBloc.add(
                    UpdateTodoEvent(TodoEntity(
                      id: widget.todo!.id,
                      title: title,
                      description: description,
                    )),
                  );
                } else {
                  widget.todoBloc.add(
                    AddTodoEvent(TodoEntity(
                      title: title,
                      description: description,
                    )),
                  );
                }

                Navigator.of(context).pop();
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
