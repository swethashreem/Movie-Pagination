import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import 'add_user_screen.dart';
import 'movie_list_screen.dart';

class UserListScreen extends ConsumerStatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(userProvider.notifier).fetchMoreUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: userState.when(
        data: (users) => ListView.builder(
          controller: _scrollController,
          itemCount: users.length + 1,
          itemBuilder: (context, index) {
            if (index < users.length) {
              final user = users[index];
              return ListTile(
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.job),
                leading:
                    CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieListScreen()),
                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
              );
            }
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
