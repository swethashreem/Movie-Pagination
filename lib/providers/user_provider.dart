import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../core/api_service.dart';
import '../models/user_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<List<UserModel>>>((ref) {
  return UserNotifier(ref.watch(apiServiceProvider));
});

class UserNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  final ApiService apiService;
  final Box _offlineBox = Hive.box('offline_users');
  int currentPage = 1;
  bool hasMore = true;

  UserNotifier(this.apiService) : super(const AsyncValue.loading()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final usersJson = await apiService.fetchUsers(currentPage);
      if (usersJson.isEmpty) {
        hasMore = false;
      }
      final users = usersJson.map((json) => UserModel.fromJson(json)).toList();
      state = AsyncValue.data(users);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> fetchMoreUsers() async {
    if (!hasMore) return;
    try {
      currentPage++;
      final moreUsersJson = await apiService.fetchUsers(currentPage);
      if (moreUsersJson.isEmpty) {
        hasMore = false;
      }
      final moreUsers = moreUsersJson.map((json) => UserModel.fromJson(json)).toList();
      final updatedUsers = [...?state.value, ...moreUsers];
      state = AsyncValue.data(updatedUsers);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addUser(String name, String job) async {
    try {
      String firstName = name;
      String lastName = '';
      if (name.contains(' ')) {
        final parts = name.split(' ');
        firstName = parts[0];
        lastName = parts.sublist(1).join(' ');
      }
      const avatarUrl = 'https://via.placeholder.com/150';
      final newUser = UserModel(firstName: firstName, lastName: lastName, avatar: avatarUrl, job: job);

      bool isOnline = true;

      if (isOnline) {
        final createdUserJson = await apiService.addUser(name, job);
        final createdUser = UserModel.fromJson({
          "first_name": newUser.firstName,
          "last_name": newUser.lastName,
          "avatar": newUser.avatar,
          "job": job,
          ...createdUserJson,
        });
        final updatedUsers = [...?state.value, createdUser];
        state = AsyncValue.data(updatedUsers);
      } else {}
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
