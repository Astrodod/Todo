import 'package:flutter/material.dart';
import '../model/todo.dart';
import 'package:todo/todo_items.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 40,
                          bottom: 10,
                        ),
                        child: const Text(
                          'All Tasks',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDOChange: _handleToDOChange,
                          onDeletedItem: _onDeleteToDoItem,
                        ),
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      left: 30,
                      right: 10,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add new Tasks',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTextItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }

// Handling change to tasks function
  void _handleToDOChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

//deletion of item with the help of their id
  void _onDeleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

//Adding tasks in the screen
  void _addTextItem(String toDo) {
    if (toDo.isNotEmpty) {
      setState(() {
        todosList.add(ToDo(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            todoText: toDo));
      });
      _todoController.clear();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter some tasks'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

// Function to search text
  void _search(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

//Creating a widget for the search box
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: ((value) => _search(value)),
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            //To make the size of search icon in searchBox fit
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

//top bar of the widget
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[300],
      elevation: 0,
      title: ListTile(
        leading: const Icon(
          Icons.person,
          color: Colors.black,
          size: 30,
        ),
        trailing: PopupMenuButton(
            itemBuilder: (context) => [
                  // popupmenu item 1
                  PopupMenuItem(
                    value: 1,
                    // row has two child icon and text.
                    child: Row(
                      children: const [
                        Icon(Icons.chrome_reader_mode),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("About"),
                      ],
                    ),
                  )
                ]
            // Icon(
            //   Icons.menu,
            //   color: Colors.black,
            ),
      ),
    );
  }
}
