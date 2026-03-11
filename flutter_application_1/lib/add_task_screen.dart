import 'package:flutter/material.dart';
import 'task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedPriority = 'Medium';
  DateTime? _selectedDeadline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.note_add,
                size: 64,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 16),
              Text(
                'Create a new task',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Fill in the details below',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  prefixIcon: Icon(Icons.title),
                  hintText: 'Enter task title',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Enter task description',
                ),
                maxLines: 4,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedPriority,
                decoration: InputDecoration(
                  labelText: 'Priority',
                  prefixIcon: Icon(Icons.priority_high),
                ),
                items: ['Low', 'Medium', 'High'].map((String priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPriority = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  // pick a date first
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    // after choosing a date, ask for a time
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _selectedDeadline = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    } else {
                      // user cancelled time picker; just use date at midnight
                      setState(() {
                        _selectedDeadline = DateTime(
                          date.year,
                          date.month,
                          date.day,
                        );
                      });
                    }
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Deadline & Time (Optional)',
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'Select deadline',
                  ),
                  child: Text(
                    _selectedDeadline != null
                        ? '${_selectedDeadline!.toLocal()}'.split('.').first
                        : 'No deadline selected',
                    style: TextStyle(
                      color: _selectedDeadline != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    final task = Task(
                      id: DateTime.now().toString(),
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdAt: DateTime.now(),
                      priority: _selectedPriority,
                      deadline: _selectedDeadline,
                    );
                    Navigator.pop(context, task);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a title'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}