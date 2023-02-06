import 'package:flutter/material.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDOChange;
  final onDeletedItem;

  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDOChange,
      required this.onDeletedItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            onToDOChange(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.blueAccent,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          title: Text(
            todo.todoText!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              icon: const Icon(Icons.delete),
              iconSize: 20,
              color: Colors.white,
              onPressed: () {
                onDeletedItem(todo.id);
              },
            ),
          ),
        ));
  }
}
