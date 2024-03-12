import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/resorces/auth_methods.dart';
import 'package:socialmedia/resorces/firestore_methods.dart';
import 'package:socialmedia/screen/login_page.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/utils.dart';
import 'package:socialmedia/widgets/following_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});
  final String uid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Column buildStckColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(userData['userName'] ?? ''),
        centerTitle: false,
      ),
      body: userData.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                NetworkImage(userData['profilepics']),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStckColumn(postsLen, "posts"),
                                    buildStckColumn(followers, "followers"),
                                    buildStckColumn(following, "following"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            text: 'Sign out',
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            textColor: Colors.white,
                                            borderColor: Colors.white,
                                            function: () async {
                                              AuthMethods().signOut();
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage(),));
                                            },
                                          )
                                        : isfollowing
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                borderColor: Colors.grey,
                                                function: () async {
                                                  FirestoreMethods().follow(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      userData['uid']);
                                                  setState(() {
                                                    isfollowing = false;
                                                    followers--;
                                                  });
                                                },
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: blueColor,
                                                textColor: Colors.white,
                                                borderColor: Colors.blue,
                                                function: () async {
                                                  FirestoreMethods().follow(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      userData['uid']);
                                                  setState(() {
                                                    isfollowing = true;

                                                    followers++;
                                                  });
                                                },
                                              )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          userData['userName'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 1.0),
                        child: Text(
                          userData['bio'],
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1.5,
                          childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
    );
  }

  var userData = {};
  var postsLen = 0;
  int followers = 0;
  int following = 0;
  bool isfollowing = false;
  bool isloading = true;
  void getdata() async {
    setState(() {
      isloading = false;
    });
    try {
      var snapsnot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnapsnot = await FirebaseFirestore.instance
          .collection('Posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      userData = snapsnot.data()!;

      setState(() {
        postsLen = postSnapsnot.docs.length;
        followers = userData['follwers'].length;
        following = userData['following'].length;
        isfollowing = (userData['following'] as List)
            .contains(FirebaseAuth.instance.currentUser!.uid);
      });
    } catch (e) {
      showsnackbar(context, e.toString());
    }

    setState(() {
      isloading = true;
    });
  }
}
