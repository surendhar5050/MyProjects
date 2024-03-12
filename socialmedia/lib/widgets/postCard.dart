import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/models.dart/user.dart';
import 'package:socialmedia/providers/user_provider.dart';
import 'package:socialmedia/resorces/firestore_methods.dart';
import 'package:socialmedia/screen/comments.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/utils.dart';
import 'package:socialmedia/widgets/linke_animation.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentCount = 0;
  void getComments() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentCount = querySnapshot.docs.length;
      setState(() {});
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.snap['profileUrl']),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.snap['userName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                children: ['Delete']
                                    .map((e) => InkWell(
                                      onTap: () {
                                        FirestoreMethods().deletePost(widget.snap['postId']);
                                        Navigator.of(context).pop();
                                      },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 16.0),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.more_vert_sharp))
                ],
              )),
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().updateLike(
                  widget.snap['postId'], user!.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.fill,
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(microseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 200),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: true,
                smallLike: true,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        snap: widget.snap,
                      ),
                    ));
                  },
                  icon: Icon(Icons.comment)),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark,
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: primaryColor),
                          children: [
                        TextSpan(
                            text: widget.snap['userName'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: widget.snap['description'],
                        )
                      ])),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Posts').doc(widget.snap['postId']).collection('comments').snapshots(),
                  builder: (context, snapshot) {

                    if (ConnectionState.waiting==snapshot.connectionState) {
                          return InkWell(
                      onTap: () {
                        // Navigator.of(context).pop(MaterialPageRoute(builder: (context) => CommentsScreen(),));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          'View all 0 comments',
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                    );
                    }
                    return InkWell(
                      onTap: () {
                        // Navigator.of(context).pop(MaterialPageRoute(builder: (context) => CommentsScreen(),));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          'View all ${(snapshot.data! as dynamic).docs.length} comments',
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePusblishd'].toDate()),
                    style: TextStyle(color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
