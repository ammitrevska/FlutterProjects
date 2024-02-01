import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 48, 136, 43)),
        useMaterial3: true,
      ),
      home: const SubjectsScreen(),
    );
  }
}

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsState();
}

class _SubjectsState extends State<SubjectsScreen> {
  List<String> _subjects = [];

  void addSubject() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newSub = '';
        return AlertDialog(
          title: const Text('Add a new subject'),
          content: TextField(
            onChanged: (value) {
              newSub = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (newSub.isNotEmpty) {
                    _subjects.add(newSub);
                  }
                  Navigator.pop(context);
                });
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }

  void editSubject(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedSub = _subjects[index];
        return AlertDialog(
          title: const Text('Edit subject'),
          content: TextField(
            controller: TextEditingController(text: editedSub),
            onChanged: (value) {
              editedSub = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _subjects[index] = editedSub;
                  Navigator.pop(context);
                });
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clothing App 191503',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'What clothes would you like?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _subjects.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    _subjects[index],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          editSubject(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            _subjects.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: addSubject,
      backgroundColor: Colors.lightGreenAccent,
      child: const Icon(Icons.add),
    ),
  );
}
}