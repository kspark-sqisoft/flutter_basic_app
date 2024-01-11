import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/network/network_info.dart';
import '../features/product/data/datasources/product_remote_data_source.dart';
import '../features/product/data/datasources/product_remote_data_source_impl.dart';
import '../features/product/data/repositories/product_repository_impl.dart';
import '../features/product/domain/repositories/product_repository.dart';
import '../features/product/domain/usecases/get_products.dart';
import '../features/product/presentation/bloc/products_bloc.dart';
import '../features/task/data/datasources/task_local_data_source.dart';
import '../features/task/data/datasources/task_local_data_source_hive_impl.dart';
import '../features/task/data/repositories/task_repository_impl.dart';
import '../features/task/domain/repositories/task_repository.dart';
import '../features/task/domain/usecases/add_task.dart';
import '../features/task/domain/usecases/delete_task.dart';
import '../features/task/domain/usecases/delete_tasks.dart';
import '../features/task/domain/usecases/get_tasks.dart';
import '../features/task/presentation/bloc/tasks_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //Bloc
  locator.registerFactory<ProductsBloc>(
      () => ProductsBloc(getProducts: locator()));

  locator.registerFactory<TasksBloc>(
    () => TasksBloc(
      getTasks: locator(),
      addTask: locator(),
      deleteTask: locator(),
      deleteTasks: locator(),
    ),
  );

  // UseCases
  locator.registerLazySingleton<GetProducts>(
      () => GetProducts(repository: locator()));

  locator
      .registerLazySingleton<GetTasks>(() => GetTasks(repository: locator()));
  locator.registerLazySingleton<AddTask>(() => AddTask(repository: locator()));
  locator.registerLazySingleton<DeleteTask>(
      () => DeleteTask(repository: locator()));
  locator.registerLazySingleton<DeleteTasks>(
      () => DeleteTasks(repository: locator()));

  // Repository
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: locator()));

  locator.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(taskLocalDataSource: locator()));

  // Data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(() =>
      ProductRemoteDataSourceImpl(client: locator(), networkInfo: locator()));

  locator.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceHiveImpl());
  //locator.registerLazySingleton<TaskLocalDataSource>(
  //    () => TaskLocalDataSourceSembastImpl());
  //locator.registerLazySingleton<TaskLocalDataSource>(
  //    () => TaskLocalDataSourceSqfliteImpl());

  // Http or Dio
  locator.registerLazySingleton(() => Dio(BaseOptions(headers: {
        'accept': 'application/json',
        'content-type': 'application/json'
      })));

  // Network Info
  locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: locator()));
  locator.registerLazySingleton(() => DataConnectionChecker());

  await locator<TaskLocalDataSource>().initDb();
}
