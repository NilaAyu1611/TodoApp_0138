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

   
    // Fungsi untuk memilih tanggal dan waktu
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null || !mounted) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null || !mounted) return;

     // Menyimpan tanggal dan waktu yang dipilih
    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
    
  }


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