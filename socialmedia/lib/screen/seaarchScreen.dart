import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:socialmedia/screen/profile_screen.dart';
import 'package:socialmedia/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool isShowingUSers = false;
  bool isloading = true;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  getdata() async {
    setState(() {
      isloading = false;
    });
    return FirebaseFirestore.instance
        .collection('users')


        .where('userName', isGreaterThanOrEqualTo: textEditingController.text)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(labelText: 'search for a text'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowingUSers = true;
              });
            },
          ),
        ),
        body: isShowingUSers
            ? isloading
                ? FutureBuilder(
                    future: getdata(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: (snapshot.data as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                  uid: (snapshot.data! as dynamic).docs[index]
                                      ['uid']),
                            )),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage((snapshot.data!
                                            as dynamic)
                                        .docs[index]['profilepics'] ??
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIgAAACICAMAAAALZFNgAAAAYFBMVEX///8AAAD7+/tiYmLy8vLGxsaysrLb29uioqLh4eG6urr39/doaGiUlJTr6+uRkZE3NzfPz88dHR1TU1Nzc3NdXV0JCQkxMTHAwMB5eXlDQ0MlJSWpqalJSUkYGBhubm6WJtA+AAACAklEQVR4nO2ZC3aCQAxFG34jfxVBVNT977LYHm2tTCowk7E9767gnhiSN/HtDQAAAAAAAAAAAAD8GzzPtUFPEZUb39+UUeFUI6noRtU6K4yq6Y5aufFY0AMLFx7lowdRKe8xUA8nNQmHPYhCYZFGJ9LIemh+GPEfJ9jqRbaBoEir9yBqBUV2nMhOUGTPiezlPAqmRfomkdt/8YETOcRiImrNiazldt/LVCRYciJLwUFScSKVnMdwBLgiGQUUJyKZ0zxf7+GLRldtHBEPJNp2lWzVC4XmC16Kv29WgxmtWUl7aL4cJy+bov6pUTt6d6bd3fJbd6kbj54gulWljiSz6gCeSrouUa9wmQDgTxDEKkyiKAlV7PDrVXl2PF3nyOmY5U4G/Koc2HpNKbz00lb76Ny3goM+5FO8VEYrzpzGhbPIFk7YZ94nh8S+R/67xoXcskaaPedBlFnt2ZTt0nsqiybe0/X4qIm9jDLKozex5fFkn35hqWNXYz2IrAx8/oI3jJW7Hntb1WHh5sqeRPSYTwbMRYTDN+0xsSDmS7KZKrIx6xGzJ16OtdmrazfVg6gzKsL+HcFj9M+KYroHkcmhlswRMZnWRq+775hcfSP3/z0G04A3o1f7bjUXkII5HkTmXsUvIxLPEzE3W+PKn0FlcMh7szDnAQAAAAAAAAAAAADs8w6dlBVrq5738QAAAABJRU5ErkJggg=='),
                              ),
                              title: Text((snapshot.data! as dynamic)
                                  .docs[index]['userName']),
                            ),
                          );
                        },
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator())
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection("Posts").get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MasonryGridView.count(
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    crossAxisCount: 3,
                    itemCount: (snapshot.data as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                          (snapshot.data! as dynamic).docs[index]['postUrl']);
                    },
                  );
                },
              ));
  }
}
