import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const CalvinApp());

class CalvinApp extends StatelessWidget {
  const CalvinApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: HomeScreen());
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _response = "Ready...";
  
  Future<void> _sendPrompt() async {
    setState(() => _response = "Processing...");
    try {
      final res = await http.post(
        Uri.parse('http://localhost:8000/ask'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'text': 'Test neural vocal processing'}),
      );
      setState(() => _response = json.decode(res.body)['text'] ?? 'No response');
    } catch (e) {
      setState(() => _response = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('🎙️ Calvin On Now', style: TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _sendPrompt, child: const Text('TEST API')),
          const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.all(20), child: Text(_response, style: const TextStyle(color: Colors.white))),
        ]),
      ),
    );
  }
}
