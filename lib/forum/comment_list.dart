import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/models/comment.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/services/auth.dart';

class CommentList extends StatefulWidget {
  final Post post;
  final TextEditingController commentController;
  const CommentList(
      {Key? key, required this.post, required this.commentController})
      : super(key: key);

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late List<Comment> commentList;
  late DateFormat dateFormat = DateFormat.yMMMMd();
  late Post post;
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataRepository repository = DataRepository();

  @override
  void initState() {
    commentList = widget.post.comments!;
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: StreamBuilder<List<Comment>>(
          stream: FirebaseFirestore.instance
              .collection('ForumDogs')
              .doc(post.referenceId)
              .snapshots()
              .map((doc) => Post.fromJson(doc.data() ?? {}))
              .map((post) => post.comments!),
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.data == null)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              );
            return ListView.builder(
              itemBuilder: (BuildContext, index) {
                return InkWell(
                    child: Card(
                      child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                            child: Text(commentList[index].body),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child: Text(commentList[index].userEmail +
                                "   " +
                                dateFormat.format(commentList[index].date)),
                          )),
                    ),
                    onLongPress: () => {
                          if (auth.currentUser!.email ==
                              commentList[index].userEmail)
                            {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: new Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          ),
                                          title: new Text('Edit'),
                                          onTap: () async {
                                            widget.commentController.text =
                                                commentList[index].body;
                                            // if (commentList[index]
                                            //         .referenceId !=
                                            //     null) {
                                            //   try {
                                            //     await FirebaseFirestore
                                            //         .instance
                                            //         .collection(
                                            //             'ForumDogs')
                                            //         .doc(post.referenceId)
                                            //         .update(
                                            //       {
                                            //         'comments': FieldValue
                                            //             .arrayRemove(
                                            //           [
                                            //             commentList[index]
                                            //                 .toJson()
                                            //           ],
                                            //         )
                                            //       },
                                            //     );
                                            //     commentList[index].body =
                                            //         widget
                                            //             .commentController
                                            //             .text;
                                            //     await FirebaseFirestore
                                            //         .instance
                                            //         .collection(
                                            //             'ForumDogs')
                                            //         .doc(post.referenceId)
                                            //         .update(
                                            //       {
                                            //         'comments': FieldValue
                                            //             .arrayUnion(
                                            //           [
                                            //             commentList[index]
                                            //                 .toJson()
                                            //           ],
                                            //         )
                                            //       },
                                            //     );
                                            //   } catch (e) {
                                            //     print(e);
                                            //   }
                                            // }
                                          },
                                        ),
                                        ListTile(
                                          leading: new Icon(
                                            Icons.delete,
                                            color: Colors.grey,
                                          ),
                                          title: new Text('Delete'),
                                          onTap: () async {
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('ForumDogs')
                                                  .doc(post.referenceId)
                                                  .update(
                                                {
                                                  'comments':
                                                      FieldValue.arrayRemove(
                                                    [
                                                      commentList[index]
                                                          .toJson()
                                                    ],
                                                  )
                                                },
                                              );
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  })
                            }
                        });
              },
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
            );
          }),
    );
    // return ListView.builder(
    //     itemCount: commentList.length,
    //     padding: const EdgeInsets.all(5.0),
    //     // separatorBuilder: (context, index) => Divider(
    //     //       height: 2.0,
    //     //       color: Colors.black87,
    //     //     ),
    //     itemBuilder: (context, index) {
    //       final item = commentList[index].body;
    //       return Dismissible(
    //           key: UniqueKey(),
    //           child: ListTile(
    //               title: Text(item),
    //               subtitle: Text(commentList[index].userEmail +
    //                   dateFormat.format(commentList[index].date))));
    //     });
  }
}
