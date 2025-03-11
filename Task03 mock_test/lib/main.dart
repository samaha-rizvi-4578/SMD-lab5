// 📂 lib/main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String storedValue = "Loading..."; // Default text

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
  }

  Future<void> _loadStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedValue = prefs.getString('saved_text') ?? "No data found";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mock Test')),
      body: Center(child: Text(storedValue)), // ✅ Displays stored value
    );
  }
}
