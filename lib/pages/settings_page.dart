import 'package:flutter/material.dart';
import 'package:learn_python/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedFontSize = 'Medium';

  final List<String> _fontSizes = ['Small', 'Medium', 'Large'];

  // Brand Colors
  final Color blue = const Color(0xFF1565C0);
  final Color green = const Color(0xFF2E7D32);
  final Color purple = const Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
            // 🔹 Appearance Section
            _buildSectionTitle("Appearance"),
            SwitchListTile(
              title: const Text("Dark Mode"),
              secondary: const Icon(Icons.dark_mode),
              value: isDarkMode,
              onChanged: (val) => themeProvider.toggleTheme(val),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Font Size",
                prefixIcon: Icon(Icons.text_fields),
              ),
              value: _selectedFontSize,
              items: _fontSizes
                  .map((size) => DropdownMenuItem(
                        value: size,
                        child: Text(size),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedFontSize = val);
                }
              },
            ),
            const SizedBox(height: 24),

            // 🔹 Notifications Section
            _buildSectionTitle("Notifications"),
            SwitchListTile(
              title: const Text("Enable Notifications"),
              secondary: const Icon(Icons.notifications),
              value: _notificationsEnabled,
              onChanged: (val) {
                setState(() => _notificationsEnabled = val);
              },
            ),
            const SizedBox(height: 24),

            // 🔹 Account Section
            _buildSectionTitle("Account"),
            ListTile(
              leading: const Icon(Icons.lock_reset),
              title: const Text("Reset App Data"),
              onTap: () => _resetAppData(),
            ),
            const SizedBox(height: 24),

            // 🔹 About Section
            _buildSectionTitle("About"),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("App Version"),
              subtitle: const Text("v1.0.0"),
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text("Developer Website"),
              onTap: () {
                // Add URL launch here if needed
              },
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

  void _resetAppData() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Reset App Data"),
        content: const Text("Are you sure you want to reset all app data?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: purple,
            ),
            onPressed: () {
              setState(() {
                // Reset example settings
                _notificationsEnabled = true;
                _selectedFontSize = 'Medium';
                final themeProvider =
                    Provider.of<ThemeProvider>(context, listen: false);
                if (themeProvider.isDarkMode) {
                  themeProvider.toggleTheme(false);
                }
              });
              Navigator.of(ctx).pop();
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }
}
