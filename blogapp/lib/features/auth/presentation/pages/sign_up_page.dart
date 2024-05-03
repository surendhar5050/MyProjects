import 'package:blogapp/core/common/widgets/loader.dart';
import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/show_snackbar.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_page.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_filed.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_grdiant_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final fromKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showSnackBar(context, state.errorMsg);
            } else if (state is AuthSucess) {

           
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Scaffold(),
              //     ));
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: fromKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthField(
                      hintText: "Name",
                      controller: _nameController,
                    ),
                    const SizedBox(
                      height: 15,
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
                      btnName: "Sign Up",
                      btnfuc: () {
                        if (fromKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignIn(
                                name: _nameController.text.trim(),
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
                        Navigator.push(context, LoginPage.route());
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Already have an account ?",
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
      ),
    );
  }
}
