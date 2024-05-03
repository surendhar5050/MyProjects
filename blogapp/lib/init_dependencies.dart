import 'package:blogapp/core/common/cubits/user/app_user_cubit.dart';
import 'package:blogapp/features/auth/data/datasources/auth_remote_data_souce.dart';
import 'package:blogapp/features/auth/data/reposistory/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domian/resposistory/auth_reposistory.dart';
import 'package:blogapp/features/auth/domian/usescase/current_user.dart';
import 'package:blogapp/features/auth/domian/usescase/user_login.dart';
import 'package:blogapp/features/auth/domian/usescase/user_sign_up.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blogapp/features/blog/data/reposistory/blog_reposistories_impl.dart';
import 'package:blogapp/features/blog/domain/reposistory/blog_reposistory.dart';
import 'package:blogapp/features/blog/domain/usescase/getall_blog.dart';
import 'package:blogapp/features/blog/domain/usescase/upload_blog.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.asNewInstance();
Future<void> initDependencies() async {
  _initAuth();
  initBlog();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
  // serviceLocator.registerLazySingleton(() => BlogBloc());

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

_initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => ImplementAuthencation(
        firebaseAuth: serviceLocator(), firebaseFirestore: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()),
  );
}

initBlog() {
  serviceLocator
      .registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceIml(
            fireStore: serviceLocator(),
            fireStorage: serviceLocator(),
            fireAuth: serviceLocator(),
          ));

  serviceLocator.registerFactory<BlogReposistory>(
    () => BlogReposistoryImp(
      blogRemoteDataSource: serviceLocator(),
    ),
  );

  serviceLocator
      .registerFactory(() => UploadBlog(blogReposistory: serviceLocator()));
  serviceLocator.registerFactory(() => GetAllBlogs(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      upLoadBlog: serviceLocator(),
      getAllBlogs: serviceLocator(),
    ),
  );
}
