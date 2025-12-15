import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomeDetailPage extends StatefulWidget {
  final String jsonFile;
  final String title;

  const HomeDetailPage({
    super.key,
    required this.jsonFile,
    required this.title,
  });

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  Map<String, dynamic>? lessonData;

  /// Track answered quizzes
  final Map<int, String> selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final String data =
        await rootBundle.loadString('assets/json/${widget.jsonFile}');
    setState(() {
      lessonData = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fc),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: lessonData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Description
                  if (lessonData!['description'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        lessonData!['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                  /// Content
                  if (lessonData!['content'] != null)
                    ...List.generate(
                      lessonData!['content'].length,
                      (index) {
                        final content = lessonData!['content'][index];
                        return _buildContentCard(
                          content['heading'],
                          content['code'],
                        );
                      },
                    ),

                  const SizedBox(height: 20),

                  /// Examples
                  if (lessonData!['examples'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Examples",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...lessonData!['examples']
                            .map<Widget>((e) => _buildCodeCard(e['code']))
                            .toList(),
                      ],
                    ),

                  const SizedBox(height: 20),

                  /// Quiz (WORKING)
                  if (lessonData!['quiz'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Quiz",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(
                          lessonData!['quiz'].length,
                          (index) {
                            final quiz = lessonData!['quiz'][index];
                            return _buildQuizCard(
                              index,
                              quiz['question'],
                              List<String>.from(quiz['options']),
                              quiz['answer'],
                            );
                          },
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  /// Summary
                  if (lessonData!['summary'] != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                            color: Colors.black.withOpacity(0.05),
                          )
                        ],
                      ),
                      child: Text(
                        "Summary: ${lessonData!['summary']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  /// Content Card
  Widget _buildContentCard(String heading, String code) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(code),
          ],
        ),
      ),
    );
  }

  /// Code Example Card
  Widget _buildCodeCard(String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff0f0f0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
        ),
      ),
    );
  }

  /// WORKING Quiz Card
  Widget _buildQuizCard(
    int index,
    String question,
    List<String> options,
    String correctAnswer,
  ) {
    final selected = selectedAnswers[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            ...options.map((option) {
              final isSelected = selected == option;
              final isCorrect = option == correctAnswer;

              Color tileColor = Colors.white;
              if (selected != null) {
                if (isCorrect) {
                  tileColor = Colors.green.shade100;
                } else if (isSelected) {
                  tileColor = Colors.red.shade100;
                }
              }

              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: selected != null
                    ? null
                    : () {
                        setState(() {
                          selectedAnswers[index] = option;
                        });

                        final correct = option == correctAnswer;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              correct ? "Correct ✅" : "Incorrect ❌",
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tileColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(option)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
