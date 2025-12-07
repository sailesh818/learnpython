import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Brand Colors
  final Color blue = const Color(0xFF1565C0);
  final Color green = const Color(0xFF2E7D32);
  final Color purple = const Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Logo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: blue,
                child: const Text(
                  "LP",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // App Name & Version
            Center(
              child: Column(
                children: const [
                  Text(
                    "Learn Python",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Description
            const Text(
              "Learn Python is a complete app designed to help beginners "
              "and advanced learners master Python programming. "
              "It includes lessons, practice exercises, quizzes, projects, "
              "and notes to enhance your learning experience.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Developer Info
            _buildSectionTitle("Developer"),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text("App Coding"),
              subtitle: Text("Email: appcoding15@gmail.com"),
            ),
            const SizedBox(height: 24),

            // Links
            _buildSectionTitle("Links"),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text("Website"),
              onTap: () {
                // Add URL launch
              },
            ),
            ListTile(
              leading: const Icon(Icons.facebook),
              title: const Text("Facebook"),
              onTap: () {
                // Add URL launch
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text("GitHub"),
              onTap: () {
                // Add URL launch
              },
            ),
            const SizedBox(height: 24),

            // License / Terms
            _buildSectionTitle("License"),
            const Text(
              "This app is free to use for learning purposes. "
              "All rights reserved © 2025.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
