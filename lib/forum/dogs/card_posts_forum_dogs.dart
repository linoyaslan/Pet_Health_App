import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/forum/post_view.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:intl/intl.dart';

class CardPostDogsForum extends StatelessWidget {
  final Post post;

  const CardPostDogsForum({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DateFormat dateFormat = DateFormat.yMMMMd();
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
          shape:
              //StadiumBorder(side: BorderSide(width: 1, color: Colors.black54, )),
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 1)),
          color: Colors.white,
          child: InkWell(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Text(
                            post.headline,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    ),
                    //Spacer(),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 46.0),
                          child: Text(
                            dateFormat.format(post.date),
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          )),
                    ),

                    //_getPetIcon(pet.type)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.red,
                                size: 17,
                              ),
                            ),
                            TextSpan(
                                text: "   " + post.likes.toString(),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                )),
                          ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: Colors.blueAccent,
                                size: 17,
                              ),
                            ),
                            TextSpan(
                                text: "   " + post.comments!.length.toString(),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                )),
                          ]),
                        )),

                    //_getPetIcon(pet.type)
                  ],
                ),
              ],
            ),
            onTap: () => Navigator.push<Widget>(
              context,
              MaterialPageRoute(
                builder: (context) => PostView(post: post),
              ),
            ),
            splashColor: Colors.blue,
          )),
    );
  }
}
