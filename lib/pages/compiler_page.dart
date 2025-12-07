import 'package:flutter/material.dart';
import 'quizzes_page.dart'; // make sure to import your QuizzesPage file

class CompilerPage extends StatefulWidget {
  const CompilerPage({super.key});

  @override
  State<CompilerPage> createState() => _CompilerPageState();
}

class _CompilerPageState extends State<CompilerPage> {
  final TextEditingController _codeController = TextEditingController();
  String _output = "";
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _codeController.text = """
# Example: Sum of first 5 numbers
total = 0
for i in range(1, 6):
    total += i
print("Sum:", total)
""";
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _runCode() async {
    setState(() {
      _isRunning = true;
      _output = "Running Python code...\n";
    });

    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay

    final code = _codeController.text;
    String result;

    try {
      if (code.contains("for") && code.contains("range") && code.contains("total")) {
        int total = 0;
        for (int i = 1; i <= 5; i++) {
          total += i;
        }
        result = "Sum: $total";
      } else {
        result = "Output simulated";
      }
    } catch (e) {
      result = "Error: $e";
    }

    setState(() {
      _output += "\n$result";
      _isRunning = false;
    });
  }

  void _goToQuizzes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizzesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Python Compiler"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: _goToQuizzes, // Navigate to QuizzesPage
            tooltip: "Go to Quizzes",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                controller: _codeController,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontFamily: 'Courier'),
                decoration: InputDecoration(
                  hintText: "Write your Python code here...",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isRunning ? null : _runCode,
              icon: _isRunning
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(_isRunning ? "Running..." : "Run"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _output,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
