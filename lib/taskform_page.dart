import 'package:flutter/material.dart';

class TaskFormPage extends StatefulWidget {
  const TaskFormPage ({super.key});

  @override
  State<TaskFormPage > createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final TextEditingController _taskController = TextEditingController();
   DateTime? _selectedDateTime;
   final List<Map<String, dynamic>> _tasks = [];
   bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Task Date & Time:', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Expanded(child: Text())
              ],
            )
          ]
        ),
        
        ),
    );
  }
}