import 'package:flutter/material.dart';
import 'quizzes_page.dart';

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
# Example: Sum of numbers
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

  Future<void> _runCode() async {
    setState(() {
      _isRunning = true;
      _output = "Running Python code...\n";
    });

    await Future.delayed(const Duration(milliseconds: 500));

    final code = _codeController.text.trim();
    String result;

    try {
      if (code.isEmpty) {
        throw Exception("No code to run");
      }

      // Extract range(start, end)
      final rangeRegex = RegExp(r'range\((\d+),\s*(\d+)\)');
      final match = rangeRegex.firstMatch(code);

      if (match != null && code.contains("total")) {
        final int start = int.parse(match.group(1)!);
        final int end = int.parse(match.group(2)!);

        int total = 0;
        for (int i = start; i < end; i++) {
          total += i;
        }

        result = "Sum: $total";
      } else {
        result = "Output simulated (unsupported code)";
      }
    } catch (e) {
      result = "Error: ${e.toString()}";
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
            onPressed: _goToQuizzes,
            tooltip: "Go to Quizzes",
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: "Clear Output",
            onPressed: () => setState(() => _output = ""),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // CODE EDITOR
            Expanded(
              flex: 3,
              child: TextField(
                controller: _codeController,
                maxLines: null,
                expands: true,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Write your Python code here...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // RUN BUTTON
            ElevatedButton.icon(
              onPressed: _isRunning ? null : _runCode,
              icon: _isRunning
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
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

            // OUTPUT CONSOLE
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
                    style: TextStyle(
                      color: _output.contains("Error")
                          ? Colors.redAccent
                          : Colors.greenAccent,
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
