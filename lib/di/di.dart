import 'dart:developer';
import 'dart:io';

import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/resources/app_const.dart';
import 'package:ant_time_flutter/usecases/favorite_usecase.dart';
import 'package:ant_time_flutter/usecases/hive_usecase.dart';
import 'package:ant_time_flutter/usecases/default_activity_usecase.dart';
import 'package:data/data.dart';
import 'package:data/interceptor/app_interceptor.dart';
import 'package:data/repository/favorites_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:domain/repository/secure_storage_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt injection = GetIt.I;

Future<void> setDI() async {
  final Dio dio = Dio(BaseOptions(
    baseUrl: AppConst.apiUrl,
    contentType: 'application/json',
  ));

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final SharedPreferencesRepository secureStorageRepository =
      SharedPreferencesRepositoryImpl(sharedPreferences);

  injection.registerLazySingleton<SharedPreferencesRepository>(
    () => secureStorageRepository,
  );
  injection.registerLazySingleton<IssuesRepository>(() => IssuesRepository(dio));
  injection.registerLazySingleton<ChecklistRepository>(() => ChecklistRepository(dio));
  injection.registerLazySingleton<ProjectsRepository>(() => ProjectsRepository(dio));
  injection
      .registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl(sharedPreferences));


  injection.registerLazySingleton<FavoriteUseCase>(() => FavoriteUseCase(
        favoritesRepository: injection(),
        issuesRepository: injection(),
      ));

  final Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter<ValueModel>(ValueModelAdapter());
  Box<ValueModel> selectedActivityBox = await Hive.openBox<ValueModel>('selected_activity_box');
  injection.registerLazySingleton<Box<ValueModel>>(() => selectedActivityBox);

  HiveUseCase<ValueModel> defaultActivityUseCase = DefaultActivityUseCase(box: injection());

  injection.registerLazySingleton<HiveUseCase<ValueModel>>(() => defaultActivityUseCase);

  dio.interceptors.add(
    AppInterceptor(secureStorageRepository: secureStorageRepository),
  );
  // ..add(
  //   LogInterceptor(logPrint: (object) => log(object.toString())),
  // );
}
