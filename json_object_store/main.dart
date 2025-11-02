import 'dart:convert';

import 'package:json_object_store_app/note.dart';

import 'file_io.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(storage: FileIo()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.storage});
  final FileIo storage;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> fileContents = [];

  void writeNoteToFile(Note n) async {
    String jsonNote = jsonEncode(n.toJson());
    await widget.storage.writeToFile(jsonNote);
  }

  void readNotesFromFile() async {
    fileContents.clear();
    fileContents.addAll(await widget.storage.readFile());
  }

  @override
  Widget build(BuildContext context) {
    var titleTec = TextEditingController();
    var detailsTec = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('File IO demo')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: titleTec,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('title'),
              ),
            ),
            TextField(
              controller: detailsTec,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('details'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleTec.text.isNotEmpty) {
                  Note n = Note(titleTec.text, detailsTec.text);
                  writeNoteToFile(n);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Data saved!')));
                  titleTec.clear();
                  detailsTec.clear();
                  readNotesFromFile();
                }
              },
              child: const Text('Write to File'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  readNotesFromFile();
                });
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Data read!')));
              },
              child: const Text('Read from File'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: fileContents.length,
                itemBuilder: (context, index) {
                  if (fileContents[index].isEmpty) {
                    return Container();
                  } else {
                    var jsonNote = jsonDecode(fileContents[index]);
                    Note n = Note.fromJson(jsonNote);
                    return ListTile(
                      title: Text(n.title),
                      subtitle: Text(n.body),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
