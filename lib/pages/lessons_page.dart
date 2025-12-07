import 'package:flutter/material.dart';
import 'package:learn_python/pages/lessons_detail_page.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fc),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Beginner Lessons"),
            _lessonCard(context, "Introduction to Python",
                "What is Python, features, installation."),
            _lessonCard(context, "Variables Data Types",
                "Numbers, Strings, Booleans, Lists, Tuples."),
            _lessonCard(context, "Operators",
                "Arithmetic, Logical, Comparison Operators."),
            _lessonCard(context, "Conditional Statements",
                "if, else, elif with examples."),
            _lessonCard(context, "Loops",
                "For loop, while loop, loop control."),

            const SizedBox(height: 20),
            _sectionTitle("Intermediate Lessons"),
            _lessonCard(context, "Functions",
                "Parameters, return values, scope."),
            _lessonCard(context, "Modules and Packages",
                "import, creating modules."),
            _lessonCard(context, "File Handling",
                "Reading and writing files in Python."),
            _lessonCard(context, "Error Handling",
                "try, except, finally, custom errors."),
            _lessonCard(context, "Object Oriented Python",
                "Classes, objects, inheritance."),

            const SizedBox(height: 20),
            _sectionTitle("Advanced Lessons"),
            _lessonCard(context, "Decorators",
                "Function wrappers, @decorators."),
            _lessonCard(context, "Generators",
                "yield, generator functions."),
            _lessonCard(context, "Multithreading",
                "Threads, concurrency."),
            _lessonCard(context, "Database Handling",
                "Connecting Python with SQL databases."),
            _lessonCard(context, "APIs and JSON",
                "Fetching and parsing JSON."),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5A2EC8), // purple tone
        ),
      ),
    );
  }

  Widget _lessonCard(BuildContext context, String title, String subtitle) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.green],
            ),
          ),
          child: const Icon(Icons.menu_book, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonDetailPage(
                title: title,
                content: subtitle,
              ),
            ),
          );
        },
      ),
    );
  }
}
