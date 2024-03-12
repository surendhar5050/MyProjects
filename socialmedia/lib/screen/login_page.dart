import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialmedia/resorces/auth_methods.dart';
import 'package:socialmedia/responsive/mobileScreen.dart';
import 'package:socialmedia/responsive/reponsive_layout_screen.dart';
import 'package:socialmedia/responsive/webScreen.dart';
import 'package:socialmedia/screen/sign_up.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/dimenions.dart';
import 'package:socialmedia/utils/utils.dart';
import 'package:socialmedia/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool isLoading = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  loginuser() async {
    setState(() {
      isLoading = false;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passController.text);
    print(res);
    if (res == 'sucess') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
            WebScreen: WebScreen(), mobileScreen: MobileScreen()),
      ));

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else {
      showsnackbar(context, res);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }

    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : EdgeInsets.symmetric(horizontal: 32.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            // ignore: deprecated_member_use
            SvgPicture.asset(
              'assets/images/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64.0,
            ),
            TextFieldInput(
                textEditingController: _emailController,
                hinttext: 'E-mail',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24.0,
            ),
            TextFieldInput(
                textEditingController: _passController,
                hinttext: 'Password',
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24.0,
            ),
            InkWell(
              splashColor: Colors.white,
              onTap: loginuser,
              child: Container(
                child: isLoading
                    ? Text('Log in')
                    : CircularProgressIndicator(
                        color: primaryColor,
                      ),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Dont't have an account"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ));
                  },
                  child: Container(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
