import 'package:flutter/material.dart';
import 'package:simple_notemark_app/utils/note_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> noteList = [
    {'title': 'Code with Zubair', 'completed': false},
    {'title': 'Learn Flutter Development', 'completed': true},
    {'title': 'Learn Dart', 'completed': true},
    {'title': 'Devby / Zubair ', 'completed': false},
  ];

  void _toggleNote(int index) {
    setState(() {
      noteList[index]['completed'] = !noteList[index]['completed'];
    });
  }

  void _addNote() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      noteList.add({'title': _controller.text.trim(), 'completed': false});
      _controller.clear();
    });
  }

  void _deleteNote(int index) {
    setState(() {
      noteList.removeAt(index);
    });
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About Simple NoteMark App'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Center(
                  child:
                      Icon(Icons.note_alt, size: 40, color: Colors.deepPurple),
                ),
                SizedBox(height: 20),
                Text('Version: 1.0.0',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Text('Developer: Zubair Ahmed'),
                Text('Email: exzubair.66@gmail.com'),
                Text('LinkedIn : https://www.linkedin.com/in/zubairahmed56/'),
                Text('GitHub: https://github.com/ZubairAhmed-56'),
                SizedBox(height: 15),
                Text(
                  'A simple and elegant note-taking application for your daily tasks.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple NoteMark App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading:
                            const Icon(Icons.info, color: Colors.deepPurple),
                        title: const Text('About App'),
                        onTap: () {
                          Navigator.pop(context);
                          _showAboutDialog(context);
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.code, color: Colors.deepPurple),
                        title: const Text('Version 1.0.0'),
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('You are using version 1.0.0'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.deepPurple.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: noteList.length,
          itemBuilder: (BuildContext context, int index) {
            return NoteItem(
              title: noteList[index]['title'],
              completed: noteList[index]['completed'],
              onChanged: (bool? value) => _toggleNote(index),
              onDelete: (BuildContext context) => _deleteNote(index),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Add new note...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
                onSubmitted: (String _) => _addNote(),
              ),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: _addNote,
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
