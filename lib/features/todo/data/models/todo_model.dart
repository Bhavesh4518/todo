
import 'package:notes/features/todo/domain/entities/todo_enitity.dart';

class TodoModel extends TodoEntity{
  TodoModel({super.id,required super.title,required super.description});

  factory TodoModel.fromMap(Map<String,dynamic> map){
    return TodoModel(
        id: map['id'],
        title: map['title'],
        description: map['description']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'description' : description
    };
  }
}