import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  final List<Map<String, String>> projects = const [
    {
      'title': 'Guess the Number',
      'difficulty': 'Beginner',
      'description': 'A simple number guessing game.',
    },
    {
      'title': 'To-Do List',
      'difficulty': 'Beginner',
      'description': 'Create and manage tasks using Python CLI.',
    },
    {
      'title': 'Tic-Tac-Toe',
      'difficulty': 'Intermediate',
      'description': 'Classic game to practice loops and lists.',
    },
    {
      'title': 'Chatbot',
      'difficulty': 'Advanced',
      'description': 'Build a simple AI chatbot using Python.',
    },
  ];

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: projects.length,
        itemBuilder: (ctx, index) {
          final project = projects[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                project['title']!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(project['description']!),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getDifficultyColor(project['difficulty']!).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  project['difficulty']!,
                  style: TextStyle(
                    color: getDifficultyColor(project['difficulty']!),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                // Navigate to project details page or show modal
              },
            ),
          );
        },
      ),
    );
  }
}
