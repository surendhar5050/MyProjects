import 'package:blogapp/core/common/widgets/loader.dart';
import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_filed.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_grdiant_button.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/show_snackbar.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final fromKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
              showSnackBar(context, state.errorMsg);
            } else if (state is AuthSucess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const BlogPage(),
                  ));
            }
        },
        builder: (context, state) {

           if (state is AuthLoading) {
              return const Loader();
            }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Log in",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hintText: "E-mail",
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                      hintText: "Password",
                      controller: _passwordController,
                      obsuretext: true),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthGradiantButton(
                    btnName: "Log in",
                    btnfuc: () {
                    if (fromKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthLogin(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ));
                    }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignUpPage.route());
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Don't have an account ?",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                              text: " Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold))
                        ])),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
