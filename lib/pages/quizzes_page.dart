import 'package:flutter/material.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _selectedOption;

  // Brand Colors
  final Color blue = const Color(0xFF1565C0);
  final Color green = const Color(0xFF2E7D32);
  final Color purple = const Color(0xFF6A1B9A);
  final Color correctColor = Colors.green;
  final Color wrongColor = Colors.red;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is the capital of Nepal?',
      'options': ['Kathmandu', 'Pokhara', 'Lalitpur', 'Bhaktapur'],
      'answer': 'Kathmandu',
    },
    {
      'question': 'Which language is used to write Flutter apps?',
      'options': ['Java', 'Dart', 'Python', 'C#'],
      'answer': 'Dart',
    },
    {
      'question': '2 + 2 = ?',
      'options': ['3', '4', '5', '6'],
      'answer': '4',
    },
  ];

  void _answerQuestion(String selected) {
    if (_selectedOption != null) return; // Prevent multiple selections
    setState(() {
      _selectedOption = selected;
      if (selected == _questions[_currentQuestionIndex]['answer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Your score: $_score / ${_questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                _selectedOption = null;
              });
            },
            child: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final options = question['options'] as List<String>;
    double progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quizzes"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [blue, green, purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(blue),
            ),
            const SizedBox(height: 16),
            Text(
              'Question ${_currentQuestionIndex + 1}/${_questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              question['question'] as String,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            // Options
            ...options.map((option) {
              Color buttonColor = purple;
              if (_selectedOption != null) {
                if (option == _selectedOption) {
                  buttonColor = option == question['answer'] ? correctColor : wrongColor;
                } else if (option == question['answer']) {
                  buttonColor = correctColor;
                } else {
                  buttonColor = purple.withOpacity(0.5);
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _selectedOption == null ? () => _answerQuestion(option) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            // Next Button
            ElevatedButton(
              onPressed: _selectedOption != null ? _nextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
