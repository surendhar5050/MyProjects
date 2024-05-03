import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTheme {



  static _border([Color borderColor = AppPallete.borderColor]) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 3));


static final lightmode=ThemeData.light().copyWith(
);

  static final darkThemeMode = ThemeData.dark().copyWith(



      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      scaffoldBackgroundColor: AppPallete.backgroundColor,




      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(AppPallete.gradient2),
          errorBorder: _border(AppPallete.errorColor)),


          
      chipTheme: const ChipThemeData(
          side: BorderSide.none,
          color: MaterialStatePropertyAll(AppPallete.backgroundColor)));
}
