import 'package:flutter/material.dart';
import 'package:learn_python/home/page/homedetail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Category → JSON mapping
  final Map<String, String> categoryFiles = {
    "Beginner": "beginner.json",
    "Intermediate": "intermediate.json",
    "Advanced": "advanced.json",
    "Exercises": "exercises.json",
    "Projects": "projects.json",
    "Interview Prep": "interview.json",
  };

  final List<Map<String, dynamic>> categories = [
    {"name": "Beginner", "icon": Icons.play_circle_fill},
    {"name": "Intermediate", "icon": Icons.bolt},
    {"name": "Advanced", "icon": Icons.auto_graph},
    {"name": "Exercises", "icon": Icons.question_answer},
    {"name": "Projects", "icon": Icons.build},
    {"name": "Interview Prep", "icon": Icons.work},
  ];

  final List<Map<String, dynamic>> continueLearning = [
    {"title": "Variables & Data Types", "progress": 0.6},
    {"title": "Loops Practice", "progress": 0.2},
    {"title": "File Handling", "progress": 0.8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        title: const Text(
          "Learn Python",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- SEARCH BAR ----------------
            TextField(
              decoration: InputDecoration(
                hintText: "Search lessons...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Categories",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return _buildCategoryCard(context, categories[index]);
              },
            ),

            const SizedBox(height: 32),

            // const Text(
            //   "Continue Learning",
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),

            //const SizedBox(height: 16),

            // Column(
            //   children: continueLearning
            //       .map((lesson) => _buildContinueCard(lesson))
            //       .toList(),
            // ),

            //const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------------- CATEGORY CARD ----------------
  Widget _buildCategoryCard(context, Map<String, dynamic> category) {
    return InkWell(
      onTap: () {
        final String? file = categoryFiles[category["name"]];
        if (file != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HomeDetailPage(jsonFile: file, title: category["name"],),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category["icon"], size: 40, color: Colors.blueAccent),
            const SizedBox(height: 12),
            Text(
              category["name"],
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- CONTINUE CARD ----------------
  // Widget _buildContinueCard(Map<String, dynamic> lesson) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 14),
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           blurRadius: 8,
  //           offset: const Offset(0, 4),
  //           color: Colors.black.withOpacity(0.05),
  //         )
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           lesson["title"],
  //           style: const TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),

  //         const SizedBox(height: 10),

  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: LinearProgressIndicator(
  //             value: lesson["progress"],
  //             backgroundColor: Colors.grey[300],
  //             minHeight: 8,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
