import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CommmentCard extends StatefulWidget {
   CommmentCard({super.key,required this.snap});
  var snap;
  @override
  State<CommmentCard> createState() => _CommmentCardState();
}

class _CommmentCardState extends State<CommmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 16.0,
        
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePics']),
            radius: 18.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.snap['Uname'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      )
                      ,    TextSpan(
                        text: '  ${widget.snap['tetx']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      )
                    ]
                  )),
          
                  Padding(padding: EdgeInsets.only(
                    top: 4.0
                  ),
                  child: Text(DateFormat.yMMMd().format(widget.snap['datepublished'].toDate(),),style: TextStyle(fontSize: 12.0,
                  fontWeight: FontWeight.w400),),)
          
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: 
            Icon(Icons.favorite,size: 16.0,),
          )
        ],
      ),
    );
  }
}