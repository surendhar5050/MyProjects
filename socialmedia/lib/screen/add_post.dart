import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/models.dart/user.dart';
import 'package:socialmedia/providers/user_provider.dart';
import 'package:socialmedia/resorces/firestore_methods.dart';
import 'package:socialmedia/utils/colors.dart';
import 'package:socialmedia/utils/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  TextEditingController descriptionController = TextEditingController();
  bool isloading = false;
  uploadPost(String uid, String userName, String profilePic) async {
    setState(() {
      isloading = true;
    });
    try {
      String res = await FirestoreMethods().upLoadpost(
          descriptionController.text, _file!, uid, userName, profilePic);

      if (res == 'Sucess') {
        setState(() {
          isloading = false;
        });
        showsnackbar(context, res);
        clearimage();
      } else {
        setState(() {
          isloading = false;
        });
        showsnackbar(context, res);
      }
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  _selectimage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Choose the Image'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20.0),
              child: Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20.0),
              child: Text('choose from galllery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20.0),
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descriptionController.dispose();
  }
  void clearimage(){
    setState(() {
      _file=null;
    });
  }
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: Container(
                child: IconButton(
                    onPressed: () {
                      _selectimage(context);
                    },
                    icon: const Icon(Icons.upload))),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              leading: IconButton(
                  onPressed: clearimage,
                  icon: const Icon(
                    Icons.arrow_back,
                  )),
              title: const Text('Post To'),
              actions: [
                TextButton(
                  onPressed: () =>
                      uploadPost(user!.uid, user.userName, user.photoUrl),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                )
              ],
            ),
            body: Column(
              children: [

                isloading?LinearProgressIndicator():Padding(padding: EdgeInsets.only(top: 0.0)),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: prefer_const_constructors
                    CircleAvatar(backgroundImage: NetworkImage(user!.photoUrl)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 8,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write  a caption'),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 251,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          )),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
