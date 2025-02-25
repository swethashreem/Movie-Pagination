import 'package:get_it/get_it.dart';
import '../core/api_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => ApiService());
}

 