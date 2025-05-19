import 'package:flutter/material.dart';

class DayDetailPage extends StatelessWidget {
  final Map<String, dynamic> day;

  const DayDetailPage({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(day['name'])),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: day['exercises'].length,
        itemBuilder: (context, index) {
          final exercise = day['exercises'][index];
          return Card(
            child: ListTile(
              title: Text(exercise['name']),
              subtitle: Text('Tekrar: ${exercise['reps']}'),
            ),
          );
        },
      ),
    );
  }
}
