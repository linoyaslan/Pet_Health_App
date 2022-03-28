import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/forum/comment_list.dart';
import 'package:pet_health_app/models/comment.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/repository/data_repository.dart';

class PostView extends StatefulWidget {
  final Post post;
  const PostView({Key? key, required this.post}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  TextEditingController commentController = TextEditingController();
  late Post post;
  late DateFormat dateFormat = DateFormat.yMMMMd();
  final DataRepository repository = DataRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Forum Dogs"),
      ),
      body: Column(
        //mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape:
                  //StadiumBorder(side: BorderSide(width: 1, color: Colors.black54, )),
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1)),
              color: Colors.white,
              child: InkWell(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.post.headline,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.post.body,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 1, 2),
                        child: Text("User:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.post.userEmail,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            dateFormat.format(post.date),
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
          Container(
            child: ListTile(
                leading: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Icon(
                    FontAwesomeIcons.comment,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                    text: '   Comments',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )),
              ]),
            )),
          ),
          Expanded(
              child: CommentList(
                  post: post, commentController: commentController)),
          Divider(),
          ListTile(
              title: TextFormField(
                key: _formKey,
                controller: commentController,
                decoration: InputDecoration(labelText: "Write a comment..."),
              ),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  //if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context);
                  final newComment = Comment(
                    userEmail: auth.currentUser!.email!,
                    body: commentController.text,
                    date: DateTime.now(),
                  );
                  post.comments!.add(newComment);
                  repository.updatePost(widget.post);
                  commentController.clear();
                  // }
                  //widget.callback();
                },
              )

              //   onPressed: () => print('add comment'),
              //   //borderSide: BorderStyle.none,
              //   //child:
              // ),
              ),
        ],
      ),
    );
  }
}
