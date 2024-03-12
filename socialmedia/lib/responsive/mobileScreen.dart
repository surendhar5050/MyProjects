import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/models.dart/user.dart' as model;
import 'package:socialmedia/providers/user_provider.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/dimenions.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  String userName = '';
int _page=2;
late PageController _pagecontroller;
  // getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)                                        // this method is  get user detials only one time whennever the state changes thatr timetime only the method get user detials
  // so because insted we using the state management
  //       .get();

  //   setState(() {
  //     userName = (snap.data() as Map<String, dynamic>)['userName'];
  //   });
  // }
navigationtap(int value){
 _pagecontroller.jumpToPage(value);
 }
 onPageChnaged(int value){
  setState(() {
    _page=value;
  });
 }
  @override
  void initState() {
    // TODO: implement initState
    // getUserName();
    super.initState();
    _pagecontroller=PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body:PageView(
            controller: _pagecontroller,
            onPageChanged: onPageChnaged,
            physics: NeverScrollableScrollPhysics(),
            children:pagescreens ,
          ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: navigationtap,
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              color:_page==0? primaryColor:secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              color:_page==1? primaryColor:secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.add_circle,
              color:_page==2? primaryColor:secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.favorite,
              color:_page==3? primaryColor:secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              color:_page==4? primaryColor:secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
