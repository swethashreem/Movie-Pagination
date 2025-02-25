import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class AddUserScreen extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: jobController,
              decoration: InputDecoration(labelText: 'Job'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text;
                final job = jobController.text;
                if (name.isNotEmpty && job.isNotEmpty) {
                  await ref.read(userProvider.notifier).addUser(name, job);
                  Navigator.pop(context);
                }
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
