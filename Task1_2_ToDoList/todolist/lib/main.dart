import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 7, 89, 61)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To-Do List HomePage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

// load tasks usig shsared preferences
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString("tasks");
    if (tasksString != null) {
      setState(() {
        tasks = List<Map<String, dynamic>>.from(json.decode(tasksString));
      });
    }
  }

Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("tasks", json.encode(tasks));
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["isCompleted"] = !tasks[index]["isCompleted"]; // "!" sign indicates not gate
    });
    saveTasks();
  }

  void deleteTask(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Are you sure you want to delete this task?'),
        action: SnackBarAction(
          label: 'Yes',
          onPressed: () {
            setState(() {
              tasks.removeAt(index);
            });
            saveTasks();
          },
        ),
      ),
    );
  }

  void editTask(int index) {
    TextEditingController taskController =
        TextEditingController(text: tasks[index]["title"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(labelText: "Task Title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks[index]["title"] = taskController.text;
                });
                saveTasks();
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void addTask() {
  TextEditingController taskController = TextEditingController();
  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(labelText: "Task Title"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskController.text.trim().isNotEmpty) {
                setState(() {
                  tasks.add({
                    "title": taskController.text,
                    "isCompleted": false,
                  });
                });
                saveTasks();
                Navigator.pop(context);  
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                tasks[index]["title"],
                style: TextStyle(
                  decoration: tasks[index]["isCompleted"]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              leading: Checkbox(
                  value: tasks[index]["isCompleted"],
                  onChanged: (value) => toggleTask(index)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => editTask(index)),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteTask(index)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
