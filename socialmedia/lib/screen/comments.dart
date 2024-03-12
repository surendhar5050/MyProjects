import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/models.dart/user.dart';
import 'package:socialmedia/providers/user_provider.dart';
import 'package:socialmedia/resorces/firestore_methods.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/widgets/comments_card.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, this.snap});
  final snap;
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('Comments'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .doc(widget.snap['postId'])
            .collection('comments').orderBy('datepublished',descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return CommmentCard(snap: (snapshot.data! as dynamic).docs[index].data(),);
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(left: 16.0, right: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16.0,
              backgroundImage: NetworkImage(
                  'https://plus.unsplash.com/premium_photo-1695219819793-159c4258875c?auto=format&fit=crop&q=80&w=1286&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      hintText: "Comment as  ${user!.userName}",
                      border: InputBorder.none),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirestoreMethods().postComment(
                    widget.snap['postId'],
                    textEditingController.text,
                    user.uid,
                    user.userName,
                    user.photoUrl);
                  textEditingController.text='';
              },

              
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: const Text(
                  "Post",
                  style: TextStyle(color: blueColor),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
