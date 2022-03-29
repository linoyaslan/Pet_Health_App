import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/forum/add_post.dart';
import 'package:pet_health_app/forum/dogs/card_posts_forum_dogs.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/services/auth.dart';

class DogsPostsList extends StatefulWidget {
  const DogsPostsList({Key? key}) : super(key: key);
  @override
  _DogsPostsListState createState() => _DogsPostsListState();
}

class _DogsPostsListState extends State<DogsPostsList> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataRepository repository = DataRepository();
  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Forum Dogs"),
      ),

      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getForumDogsStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _addPost();
        },
        tooltip: 'Add Post',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost()));
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    //final User? user = auth.currentUser;
    final post = Post.fromSnapshot(snapshot);
    Stream<QuerySnapshot<Map<String, dynamic>>> collection =
        FirebaseFirestore.instance.collection("ForumDogs").snapshots();
    // if (collection.isEmpty == true) {
    //   return CardPostDogsForum();
    // }
    return CardPostDogsForum(post: post);
  }
}