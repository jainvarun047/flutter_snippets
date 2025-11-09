import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_tasks_app/constants.dart';
import 'package:my_tasks_app/task.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _tasksBox = Hive.box(Constants.MY_TASKS_BOX);
  List _tasks = [];

  final _titleTec = TextEditingController();
  final _tagsTec = TextEditingController();
  final _detailsTec = TextEditingController();

  @override
  void initState() {
    // get tasks from the hive box

    for (var key in _tasksBox.keys) {
      if (key.toString().contains("Task-")) {
        _tasks.add(Task.fromJson(jsonDecode(_tasksBox.get(key))));
      }
    }

    super.initState();
  }

  void showTaskDialog(Widget action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'title'),
              controller: _titleTec,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'tags'),
              controller: _tagsTec,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'details'),
              maxLines: null,
              controller: _detailsTec,
            ),
          ],
        ),
        actions: [action],
      ),
    ).then((value) {
      _titleTec.clear();
      _tagsTec.clear();
      _detailsTec.clear();
    });
  }

  void addTask() {
    var task = Task(_titleTec.text, _detailsTec.text, _tagsTec.text.split(','));
    setState(() {
      _tasks.add(task);
    });
    _tasksBox.put(task.id, jsonEncode(task.toJson()));
  }

  void updateTask(int index, Task t) {
    setState(() {
      _tasks.removeAt(index);
      _tasks.add(t);
    });
    _tasksBox.put(t.id, jsonEncode(t.toJson()));
  }

  void deleteTask(int index) {
    Task t = _tasks[index];
    setState(() {
      _tasks.removeAt(index);
    });
    _tasksBox.delete(t.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTaskDialog(
          TextButton(
            onPressed: () {
              addTask();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            Task task = _tasks[index];
            return Row(
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      task.toggleStatus();
                    });
                    updateTask(index, task);
                  },
                ),
                Expanded(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.details),
                    onTap: () {
                      _titleTec.text = task.title;
                      _tagsTec.text = task.tags.join(',');
                      _detailsTec.text = task.details;
                      showTaskDialog(
                        TextButton(
                          onPressed: () {
                            task.title = _titleTec.text;
                            task.details = _detailsTec.text;
                            task.tags = _tagsTec.text.split(',');
                            updateTask(index, task);

                            Navigator.pop(context);
                          },
                          child: const Text('Update'),
                        ),
                      );
                    },
                    trailing: IconButton(
                      onPressed: () {
                        deleteTask(index);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
