// import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/screen/add_post.dart';
import 'package:socialmedia/screen/feed_screen.dart';
import 'package:socialmedia/screen/profile_screen.dart';
import 'package:socialmedia/screen/seaarchScreen.dart';

const webScreenSize = 600;

var pagescreens = [
  FeedScreen(),
  SearchScreen(),
  AddPost(),
  Text('Favorite'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];
