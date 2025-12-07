import 'package:flutter/material.dart';
import 'package:learn_python/pages/lessons_detail_page.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomeDetailPage extends StatefulWidget {
  final String jsonFile; // JSON file to load
  final String title; // Category or lesson title

  const HomeDetailPage({super.key, required this.jsonFile, required this.title});

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  Map<String, dynamic>? lessonData;

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final String data = await rootBundle.loadString('assets/json/${widget.jsonFile}');
    setState(() {
      lessonData = json.decode(data);
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
      body: lessonData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  if (lessonData!['description'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        lessonData!['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                  // Content Section
                  if (lessonData!['content'] != null)
                    ...List.generate(lessonData!['content'].length, (index) {
                      final content = lessonData!['content'][index];
                      return _buildContentCard(content['heading'], content['code']);
                    }),

                  const SizedBox(height: 20),

                  // Examples Section
                  if (lessonData!['examples'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Examples",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(lessonData!['examples'].length, (index) {
                          final example = lessonData!['examples'][index];
                          return _buildCodeCard(example['code']);
                        }),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Quiz Section
                  if (lessonData!['quiz'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Quiz",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(lessonData!['quiz'].length, (index) {
                          final quiz = lessonData!['quiz'][index];
                          return _buildQuizCard(
                            quiz['question'],
                            List<String>.from(quiz['options']),
                            quiz['answer'],
                          );
                        }),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Summary
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
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildContentCard(String heading, String code) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        title: Text(
          heading,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(code),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonDetailPage(title: heading, content: code),
            ),
          );
        },
      ),
    );
  }

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
        style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
      ),
    );
  }

  Widget _buildQuizCard(String question, List<String> options, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...options.map(
              (option) => ListTile(
                title: Text(option),
                leading: const Icon(Icons.circle_outlined, size: 16),
                onTap: () {
                  final correct = option == answer;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(correct ? "Correct ✅" : "Incorrect ❌"),
                      duration: const Duration(seconds: 1),
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
