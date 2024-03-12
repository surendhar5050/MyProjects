import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/dimenions.dart';
import 'package:socialmedia/widgets/postCard.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myWidth > webScreenSize
          ? null
          : AppBar(
              backgroundColor: myWidth > webScreenSize
                  ? webBackgroundColor
                  : mobileBackgroundColor,
              title: SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 32.0,
              ),
              centerTitle: false,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.messenger))
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, ind) {
              return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: myWidth > webScreenSize
                          ? MediaQuery.of(context).size.width * 0.3
                          : 0,
                      vertical: myWidth > webScreenSize
                          ? MediaQuery.of(context).size.width * 0.3
                          : 0),
                  child: PostCard(
                    snap: snapshot.data!.docs[ind].data(),
                  ));
            },
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}
