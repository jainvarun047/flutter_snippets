import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the box
  final _myBox = Hive.box("MyBox");
  final _ToDoListBox = "ToDoList";

  final _textController = TextEditingController();

  List todos = [];

  @override
  void initState() {
    // load data, if no data, default to empty list
    todos = _myBox.get(_ToDoListBox) ?? [];
    super.initState();
  }

  // todo dialog
  void openNewTodo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('add task'),
        content: TextField(controller: _textController),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _textController.clear();
            },
            child: const Text('Cancel'),
          ),
          // add button
          TextButton(
            onPressed: () {
              addTodo();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // add todo
  void addTodo() {
    String todo = _textController.text;
    setState(() {
      todos.add(todo);
      _textController.clear();
    });
    saveToDatabase();
  }

  // delete todo
  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
    saveToDatabase();
  }

  // save todo
  void saveToDatabase() {
    _myBox.put(_ToDoListBox, todos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openNewTodo,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo),
            trailing: IconButton(
              onPressed: () => deleteTodo(index),
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
