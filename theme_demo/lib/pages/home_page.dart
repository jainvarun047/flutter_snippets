import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_demo_app/components/drawer.dart';
import 'package:theme_demo_app/theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          (Provider.of<ThemeProvider>(context, listen: false).isDarkMode)
              ? 'DarkMode'
              : 'LightMode',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        elevation: 10,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: Text(
          'Hello World!',
          style: TextStyle(
            fontSize: 50,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
