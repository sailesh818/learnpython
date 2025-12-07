import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonDetailPage extends StatefulWidget {
  final String title;
  final String content;

  const LessonDetailPage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  Map<String, dynamic>? lessonData;
  int score = 0;
  int currentQuestion = 0;
  String? selectedOption;
  bool quizFinished = false;

  @override
  void initState() {
    super.initState();
    loadLesson();
  }

  Future<void> loadLesson() async {
    final String fileName =
        widget.title.toLowerCase().replaceAll(" ", "_") + ".json";

    String data =
        await rootBundle.loadString("assets/lessons/$fileName");

    setState(() {
      lessonData = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lessonData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final quiz = lessonData!["quiz"];

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fc),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Overview
            _section("📘 Overview", lessonData!["overview"]),

            const SizedBox(height: 20),

            // Topics
            _sectionList("📖 Key Topics", lessonData!["topics"]),

            const SizedBox(height: 20),

            // Examples
            _sectionList("🧪 Examples", lessonData!["examples"], code: true),

            const SizedBox(height: 20),

            // Practice Tasks
            _sectionList("📝 Practice Tasks", lessonData!["practice"]),

            const SizedBox(height: 20),

            // Quiz
            _quizSection(quiz),

            const SizedBox(height: 20),

            _section("📌 Summary", lessonData!["summary"]),
          ],
        ),
      ),
    );
  }

  // SECTION TITLE + TEXT
  Widget _section(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5A2EC8),
          ),
        ),
        const SizedBox(height: 8),
        _card(Text(text, style: const TextStyle(fontSize: 16)))
      ],
    );
  }

  // LIST SECTIONS (Topics, Examples, Practice)
  Widget _sectionList(String title, List items, {bool code = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A2EC8)),
        ),
        const SizedBox(height: 8),
        _card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(code ? ">>> $item" : "• $item",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: code ? "monospace" : null,
                    )),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // QUIZ
  Widget _quizSection(List quiz) {
    if (quizFinished) {
      return _card(
        Column(
          children: [
            const Text("🎉 Quiz Completed!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Score: $score / ${quiz.length}",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    final q = quiz[currentQuestion];

    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("❓ Quiz",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Text(q["question"],
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600)),

          const SizedBox(height: 10),

          ...List.generate(q["options"].length, (i) {
            final option = q["options"][i];
            return RadioListTile(
              title: Text(option),
              value: option,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() => selectedOption = value);
              },
            );
          }),

          ElevatedButton(
            onPressed: () {
              if (selectedOption == q["answer"]) score++;

              if (currentQuestion < quiz.length - 1) {
                setState(() {
                  currentQuestion++;
                  selectedOption = null;
                });
              } else {
                setState(() => quizFinished = true);
              }
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  Widget _card(Widget child) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
