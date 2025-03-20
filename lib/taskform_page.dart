import 'package:flutter/material.dart';
import 'package:intl/intl.dart';        // Package untuk memformat tanggal dan waktu

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
  void initState() {
    super.initState();
    // Listener untuk mengecek apakah inputan kosong atau tidak
    _taskController.addListener(() {
      setState(() {
        _showError = _taskController.text.isEmpty;
      });
    });
  }

   
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

   void _addTask() {
    if (_taskController.text.isNotEmpty && _selectedDateTime != null) {
      setState(() {
        _tasks.add({
          'name': _taskController.text,
          'date': _selectedDateTime!,
          'done': false,
        });
        _taskController.clear();
        _selectedDateTime = null;
        _showError = false;
      });
    } else{
      setState(() {
        _showError = true;    // Menampilkan pesan error jika input kosong
      });
    }
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
                Expanded(
                  child: Text(
                    _selectedDateTime == null
                        ? 'Select a date and time'
                        : DateFormat('dd-MM-yyyy HH:mm').format(_selectedDateTime!),
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedDateTime == null ? Colors.red : Colors.black,
                    ),
                  ),
                  ),
                  IconButton(
                  icon: const Icon(Icons.calendar_today, color: Color.fromARGB(255, 23, 84, 134)),
                  onPressed: () => _selectDateTime(context),
                ),

              ],
            ),
            const SizedBox(height: 10),

            // Inputan untuk nama tugas
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Task Name',
                hintText: 'Enter task name',
                border: const OutlineInputBorder(),
              ),
            ),

            // Pesan error jika inputan kosong
            if (_showError) 
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Task name cannot be empty!',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 95, 103, 15),
              ),
              child: const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            const Text('List Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

             // Daftar tugas yang ditampilkan dalam bentuk ListView
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,    // Jumlah tugas dalam daftar
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(134, 247, 244, 239),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_tasks[index]['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                        ],
                      ),

                      
                    ),
                  );
                },
              ),
            ),
          ]
        ),
        
        ),
    );
  }
}