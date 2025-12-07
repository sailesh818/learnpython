import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  // Brand Colors
  final Color blue = const Color(0xFF1565C0);
  final Color green = const Color(0xFF2E7D32);
  final Color purple = const Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    // Example progress values (replace with dynamic data later)
    final double lessonsProgress = 0.7; // 70%
    final double practiceProgress = 0.5; // 50%
    final double quizzesProgress = 0.3; // 30%

    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Section Title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your Learning Progress",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            // 🔹 Lessons Progress Card
            _buildProgressCard(
              title: "Lessons Completed",
              progress: lessonsProgress,
              color: blue,
            ),

            const SizedBox(height: 16),

            // 🔹 Practice Progress Card
            _buildProgressCard(
              title: "Practice Completed",
              progress: practiceProgress,
              color: green,
            ),

            const SizedBox(height: 16),

            // 🔹 Quizzes Progress Card
            _buildProgressCard(
              title: "Quizzes Completed",
              progress: quizzesProgress,
              color: purple,
            ),

            const SizedBox(height: 24),

            // 🔹 Overall Score
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Overall Score",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: (lessonsProgress + practiceProgress + quizzesProgress) / 3,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
              minHeight: 12,
            ),
            const SizedBox(height: 8),
            Text(
              "${(((lessonsProgress + practiceProgress + quizzesProgress) / 3) * 100).toStringAsFixed(0)}%",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Progress Card Builder
  Widget _buildProgressCard({
    required String title,
    required double progress,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 12,
            ),
            const SizedBox(height: 8),
            Text("${(progress * 100).toStringAsFixed(0)}%",
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
