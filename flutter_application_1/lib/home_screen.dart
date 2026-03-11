import 'package:flutter/material.dart';
import 'task.dart';
import 'add_task_screen.dart';
import 'storage_service.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  String? _filterPriority; // null = no filter

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    _tasks = await StorageService.loadTasks();
    setState(() {});
  }

  void _addTask(Task task) async {
    _tasks.add(task);
    await StorageService.saveTasks(_tasks);
    setState(() {});
  }

  void _toggleTask(Task task) async {
    final index = _tasks.indexOf(task);
    _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
    await StorageService.saveTasks(_tasks);
    setState(() {});
  }

  void _deleteTask(Task task) async {
    _tasks.remove(task);
    await StorageService.saveTasks(_tasks);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: _buildPriorityNavBar(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.onThemeToggle,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/auth');
            },
          ),
        ],
      ),
      body: bodyContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final task = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (task != null) {
            _addTask(task);
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPriorityNavBar() {
    final counts = {
      'Low': _tasks.where((t) => t.priority == 'Low').length,
      'Medium': _tasks.where((t) => t.priority == 'Medium').length,
      'High': _tasks.where((t) => t.priority == 'High').length,
    };

    Widget button(String label) {
      final selected = _filterPriority == label;
      return GestureDetector(
        onTap: () {
          setState(() {
            if (_filterPriority == label) {
              _filterPriority = null;
            } else {
              _filterPriority = label;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  counts[label].toString(),
                  style: TextStyle(
                    color: selected ? Theme.of(context).primaryColor : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [button('Low'), button('Medium'), button('High')],
      ),
    );
  }

  Widget bodyContent() {
    final filtered = _filterPriority == null
        ? _tasks
        : _tasks.where((t) => t.priority == _filterPriority).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No tasks yet',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add your first task!',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final task = filtered[index];
        final bool even = index % 2 == 0;
        final Color background = even
            ? Theme.of(context).cardColor
            : Theme.of(context).cardColor.withOpacity(0.85);
        final Color textColor = task.isCompleted
            ? Colors.grey
            : (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white);
        return Card(
          color: background,
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) => _toggleTask(task),
              activeColor: Theme.of(context).primaryColor,
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: task.isCompleted ? Colors.grey : textColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.description,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: task.isCompleted ? Colors.grey : textColor,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        //color: _getPriorityColor(task.priority),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        task.priority,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (task.deadline != null) ...[
                      SizedBox(width: 8),
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        '${task.deadline!.toLocal()}'.split('.').first,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTask(task),
            ),
          ),
        );
      },
    );
  }
}