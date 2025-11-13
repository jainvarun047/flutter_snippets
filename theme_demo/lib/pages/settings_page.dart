import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_demo_app/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Settings',
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
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('DarkMode', style: TextStyle(fontWeight: FontWeight.bold)),
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).isDarkMode,
              onChanged: (value) => Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
