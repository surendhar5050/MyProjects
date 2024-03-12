import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/resorces/auth_methods.dart';
import 'package:socialmedia/responsive/mobileScreen.dart';
import 'package:socialmedia/responsive/reponsive_layout_screen.dart';
import 'package:socialmedia/responsive/webScreen.dart';
import 'package:socialmedia/screen/login_page.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/utils.dart';
import 'package:socialmedia/widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Uint8List? profileimage;

  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = true;
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void imagepicker() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      profileimage = im;
    });
  }

  singnupUser() async {
    setState(() {
      _isLoading = false;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passController.text,
        userName: _userNameController.text,
        bio: _bioController.text,
        file: profileimage!);

    setState(() {
      _isLoading = true;
    });
    if (res == 'sucess') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>const ResponsiveLayout(
            WebScreen: WebScreen(), mobileScreen: MobileScreen()),
      ));
    } else {
      // ignore: use_build_context_synchronously
      showsnackbar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              // ),
              // ignore: deprecated_member_use
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64.0,
              ),
              Stack(
                children: [
                  profileimage != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(profileimage!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage('assets/images/download.jpeg'),
                        ),
                  Positioned(
                      left: 80,
                      bottom: -10,
                      child: IconButton(
                          onPressed: imagepicker,
                          icon: const Icon(Icons.add_a_photo)))
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInput(
                  textEditingController: _userNameController,
                  hinttext: 'Enter the username ',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24.0,
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
              TextFieldInput(
                  textEditingController: _bioController,
                  hinttext: 'Enter the bio',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24.0,
              ),
              InkWell(
                splashColor: Color.fromARGB(255, 155, 121, 121),
                onTap: singnupUser,
                child: Container(
                  child: _isLoading
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
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Already have an account"),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: Container(
                      child: Text(
                        "Log in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
