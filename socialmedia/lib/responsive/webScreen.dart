import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/dimenions.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  String userName = '';

  int _page = 2;

  late PageController _pagecontroller;

  // getUserName() async {
  navigationtap(int value) {
    _pagecontroller.jumpToPage(value);
      setState(() {
      _page = value;
    });
  }

  onPageChnaged(int value) {
    setState(() {
      _page = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // getUserName();
    super.initState();
    _pagecontroller = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/images/ic_instagram.svg',
          color: primaryColor,
          height: 32.0,
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () =>navigationtap(0),
              icon: Icon(
                Icons.home,
                color:_page==0? primaryColor:secondaryColor,
              )),
          IconButton(
              onPressed: () =>navigationtap(1),
              icon: Icon(
                Icons.search,
                color:_page==1? primaryColor:secondaryColor,
              )),
          IconButton(
              onPressed: () =>navigationtap(2),
              icon: Icon(
                Icons.add_a_photo,
                color:_page==2? primaryColor:secondaryColor,
              )),
          IconButton(
              onPressed: () =>navigationtap(3),
              icon: Icon(
                Icons.favorite,
                color:_page==3? primaryColor:secondaryColor,
              )),
          IconButton(
              onPressed: () =>navigationtap(4),
              icon: Icon(
                Icons.person,
                color:_page==4? primaryColor:secondaryColor,
              ))



        ],
      ),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children:pagescreens,
        controller: _pagecontroller,
        onPageChanged: onPageChnaged,

      ),
    );
  }
}
