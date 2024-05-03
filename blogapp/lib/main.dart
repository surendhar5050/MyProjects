import 'package:blogapp/core/common/cubits/user/app_user_cubit.dart';
import 'package:blogapp/core/theme/theme.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_page.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),

          //  AuthBloc(
          //     userSignUp: UserSignUp(
          //   AuthRepositoryImpl(
          //     ImplementAuthencation(
          //       firebaseAuth: FirebaseAuth.instance,
          //     ),
          //   ),
          // )),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),

        BlocProvider(
          create: (_) => serviceLocator<BlogBloc>(),)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // context.read<AuthBloc>().add(AuthIsUserLoggedIn());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.darkThemeMode,
        home: LoginPage()

        // BlocSelector<AppUserCubit, AppUserState, bool>(
        //   selector: (state) {
        //     return state is AppUserLoggedIn;
        //   },
        //   builder: (context, isLoggedIn) {
        //         //  if (isLoggedIn) {
        //         //     return const Scaffold(body: Center(child: Text("Logged IN"),),);
        //         //  }

        //     return const LoginPage();
        //   },
        // ),
        );
  }
}
