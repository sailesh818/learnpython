import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  final String _feedbackEmail = 'appcoding15@gmail.com';

  @override
  Widget build(BuildContext context) {
    // Brand Colors
    final Color blue = const Color(0xFF1565C0);
    final Color green = const Color(0xFF2E7D32);
    final Color purple = const Color(0xFF6A1B9A);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.feedback,
                size: 80,
                color: Colors.black54,
              ),
              const SizedBox(height: 24),
              const Text(
                "We value your feedback!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Please send your feedback to our email:",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SelectableText(
                _feedbackEmail,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: purple,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [blue, green, purple],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Copy the email and send feedback",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
