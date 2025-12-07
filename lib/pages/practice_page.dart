import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class PracticePage extends StatefulWidget {
  final String jsonFile; // JSON file to load
  final String title;

  const PracticePage({super.key, required this.jsonFile, required this.title});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  List<dynamic> questions = [];

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final String data = await rootBundle.loadString('assets/${widget.jsonFile}');
    setState(() {
      final jsonResult = json.decode(data);
      questions = jsonResult['questions'] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xfff8f9fc),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: ListTile(
                    title: Text(
                      "Q${index + 1}: ${question['question']}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: question.containsKey('hint')
                        ? Text("Hint: ${question['hint']}")
                        : null,
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        _showAnswerDialog(question);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showAnswerDialog(Map<String, dynamic> question) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Solution"),
        content: Text(question['solution'] ?? "Try coding this yourself!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
