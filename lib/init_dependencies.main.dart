part of "init_dependencies.dart";

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      anonKey: AppSecrets.supabaseKey, url: AppSecrets.supabaseUrl);
  serviceLocator.registerLazySingleton(() => supabase.client);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  //core auth
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
}

_initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImp(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    ..registerFactory(() =>
        BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()));
}
