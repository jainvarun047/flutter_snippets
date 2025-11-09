import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:my_tasks_app/constants.dart';
import 'package:my_tasks_app/task_page.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();
  // open a box in hive
  await Hive.openBox(Constants.MY_TASKS_BOX);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksPage(),
    );
  }
}
