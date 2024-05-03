import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradiantButton extends StatelessWidget {
  final VoidCallback btnfuc;
  final String btnName;
 const AuthGradiantButton({super.key, required this.btnfuc, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [AppPallete.gradient1, AppPallete.gradient2])),
      child: ElevatedButton(
        onPressed: btnfuc,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          btnName,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
