import 'package:get_it/get_it.dart';
import 'service/authentication.dart';
import 'service/dialog_service.dart';
import 'service/firestore_service.dart';
import 'service/navigation_service.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FirestoreService());
  //locator.registerLazySingleton(() => CloudStorageService());
  //locator.registerLazySingleton(() => ImageSelector());
}