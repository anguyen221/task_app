import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});
  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController taskController = TextEditingController();
  List<Task> tasks = [];

  void addTask() {
    setState(() {
      if (taskController.text.isNotEmpty) {
        tasks.add(Task(name: taskController.text, isCompleted: false));
        taskController.clear();
      }
    });
  }

  void toggleCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Enter Task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              child: Text('Add Task'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        tasks[index].name,
                        style: TextStyle(
                          decoration: tasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: tasks[index].isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                      leading: Checkbox(
                        value: tasks[index].isCompleted,
                        onChanged: (value) {
                          toggleCompletion(index);
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, required this.isCompleted});
}
