import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FilterChips Example')),
        body: const FilterChipExample(),
      ),
    );
  }
}

class FilterChipExample extends StatefulWidget {
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  Map<String, List<String>> filters = {
    "walking": ["value1", "value2"],
    "running": ["value2", "value3"],
    "cycling": ["value3", "value1"],
    "hiking": ["value2"],
  };

  Set<String> selectedFilters = <String>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        children: [
          Text('Choose an filter...', style: textTheme.labelLarge),
          const SizedBox(height: 5),
          Wrap(
            spacing: 5,
            children: filters.keys.map((String s) {
              return FilterChip(
                label: Text(s),
                selected: selectedFilters.contains(s),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedFilters.add(s);
                    } else {
                      selectedFilters.remove(s);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Looking for: ${selectedFilters.map((String s) => filters[s]!.join(',')).join('\n')}',
            style: textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
