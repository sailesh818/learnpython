import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Map<String, String>> _notes = [];

  // Brand Colors
  final Color blue = const Color(0xFF1565C0);
  final Color green = const Color(0xFF2E7D32);
  final Color purple = const Color(0xFF6A1B9A);

  void _addOrEditNote({int? index}) async {
    String title = '';
    String content = '';

    if (index != null) {
      title = _notes[index]['title']!;
      content = _notes[index]['content']!;
    }

    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController contentController = TextEditingController(text: content);

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(index == null ? 'New Note' : 'Edit Note'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => title = val,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 6,
                  onChanged: (val) => content = val,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              title = titleController.text.trim();
              content = contentController.text.trim();
              if (title.isEmpty && content.isEmpty) return;
              setState(() {
                if (index != null) {
                  _notes[index] = {'title': title, 'content': content};
                } else {
                  _notes.add({'title': title, 'content': content});
                }
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteNote(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Note?'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _notes.removeAt(index));
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
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
      body: _notes.isEmpty
          ? const Center(
              child: Text(
                "No notes yet. Click + to add a note.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _notes.length,
                itemBuilder: (ctx, index) {
                  final note = _notes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        note['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        note['content']!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNote(index),
                      ),
                      onTap: () => _addOrEditNote(index: index),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditNote(),
        child: const Icon(Icons.add),
        backgroundColor: purple,
      ),
    );
  }
}
