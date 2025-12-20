import 'package:flutter/material.dart';
import 'package:learn_python/home/page/home_page.dart';
import 'package:learn_python/pages/about_page.dart';
import 'package:learn_python/pages/compiler_page.dart';
import 'package:learn_python/pages/feedback_page.dart';
import 'package:learn_python/pages/lessons_page.dart';
import 'package:learn_python/pages/notes_page.dart';
import 'package:learn_python/pages/practice_page.dart';
//import 'package:learn_python/pages/profile_page.dart';
//import 'package:learn_python/pages/progress_page.dart';
import 'package:learn_python/pages/projects_page.dart';
import 'package:learn_python/pages/quizzes_page.dart';
import 'package:learn_python/pages/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const LessonsPage(),
    const PracticePage(jsonFile: 'practice.json', title: 'Python Exercises',),
    //const ProfilePage(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Brand Colors
  final Color blue = const Color(0xFF1565C0);
  final Color green = const Color(0xFF2E7D32);
  final Color purple = const Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Gradient AppBar
      appBar: AppBar(
        title: const Text("Learn Python"),
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

      // 🔹 Beautiful Drawer UI
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [blue.withOpacity(0.85), purple.withOpacity(0.85)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [purple, blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Learn Python",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              drawerItem(Icons.code, "Compiler", const CompilerPage()),
              drawerItem(Icons.quiz, "Quizzes", const QuizzesPage()),
              drawerItem(Icons.book, "Projects", const ProjectsPage()),
              drawerItem(Icons.note_alt, "Notes", const NotesPage()),
              //drawerItem(Icons.bar_chart, "Progress", const ProgressPage()),
              drawerItem(Icons.settings, "Settings", const SettingsPage()),
              drawerItem(Icons.info, "About", const AboutPage()),
              drawerItem(Icons.feedback, "Feedback", const FeedbackPage()),
            ],
          ),
        ),
      ),

      // Main Body
      body: _pages[_selectedIndex],

      // 🔹 Beautiful Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [blue, purple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _selectedIndex,
          onTap: _onNavTap,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Lessons"),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: "Practice"),
            //BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }

  // 🔹 Drawer Tile Builder
  Widget drawerItem(IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}
