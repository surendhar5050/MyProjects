import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/providers/user_provider.dart';
import 'package:socialmedia/utils/dimenions.dart';


class ResponsiveLayout extends StatefulWidget {
  final Widget WebScreen;
  final Widget mobileScreen;

  const ResponsiveLayout({super.key,required this.WebScreen,required this.mobileScreen});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

addData()async{
  UserProvider _userProvider=Provider.of(context ,listen: false);
  
await  _userProvider.refreshUser();
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<webScreenSize){
          return widget.mobileScreen;
      }
      return widget.WebScreen;

    },);
  }
}