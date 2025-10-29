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
  List<String> fileContents = ['No data to read yet...'];

  void readFileContents() async {
    fileContents.addAll(await widget.storage.readFile());
  }

  @override
  Widget build(BuildContext context) {
    var tec = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('File IO demo')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: tec,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.storage.writeToFile(tec.text);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Data saved!')));
                tec.clear();
                readFileContents();
              },
              child: const Text('Write to File'),
            ),
            ElevatedButton(
              onPressed: () async {
                final content = await widget.storage.readFile();
                setState(() {
                  fileContents = content;
                });
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Data read!')));
              },
              child: const Text('Read from File'),
            ),
            const SizedBox(height: 20),
            Text('File Content: $fileContents'),
          ],
        ),
      ),
    );
  }
}
