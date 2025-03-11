import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  String storedValue = "No value saved";

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedValue = prefs.getString('saved_text') ?? "No value saved";
    });
  }

  Future<void> _saveValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_text', _controller.text);
    _loadValue();
    _controller.clear();
  }

  Future<void> _clearValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_text');
    _loadValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SharedPreferences Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter text",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveValue,
              child: Text("Save Value"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _clearValue,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Clear Value"),
            ),
            SizedBox(height: 20),
            Text(
              "Stored Value: $storedValue",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
