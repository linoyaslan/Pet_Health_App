import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_health_app/models/forum.dart';
import 'package:pet_health_app/models/user.dart';
import 'package:pet_health_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_health_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:pet_health_app/models/user.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          soundSource:
              'resource://raw/android_app_src_main_res_raw_res_custom_notification')
    ],
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // CollectionReference collection =
  //     FirebaseFirestore.instance.collection("Forum");
  // var collectionForumDogs = await collection.where('subject', isEqualTo: 'Dogs').get();
  // var docCats = await collection.where('subject', isEqualTo: 'Cats').get();
  // var docOther = await collection.where('subject', isEqualTo: 'Other').get();
  // if (docDogs.size == 0) {
  //   Forum dogs = Forum(subject: "Dogs", posts: []);
  //   createCollection(dogs);
  // }
  // if (docCats.size == 0) {
  //   Forum cats = Forum(subject: "Cats", posts: []);
  //   createCollection(cats);
  // }
  // if (docOther.size == 0) {
  //   Forum other = Forum(subject: "Other", posts: []);
  //   createCollection(other);
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      // adding because of eroor
      initialData: null,
      // until here adding because of error

      child: MaterialApp(
        home: Wrapper(),
      ),
      catchError: (_, __) => null,
    );
  }
}

createCollection(Forum forum) async {
  await FirebaseFirestore.instance.collection("Forum").add(forum.toJson());
}
