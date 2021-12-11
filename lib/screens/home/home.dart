// import 'package:flutter/material.dart';
// import 'package:pet_health_app/models/pet.dart';
// import 'package:pet_health_app/repository/data_repository.dart';
// import 'package:pet_health_app/services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Home extends StatelessWidget {
//   //const Home({Key? key}) : super(key: key);

//   final AuthService _auth = AuthService();
//   final DataRepository repository = DataRepository();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[50],
//       appBar: AppBar(
//         title: Text('Pet Health'),
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         actions: <Widget>[
//           FlatButton.icon(
//             icon: Icon(Icons.logout_outlined),
//             label: Text('Logout'),
//             onPressed: () async {
//               await _auth.signOut();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/blocks/application_block.dart';
import 'package:pet_health_app/home_list.dart';
import 'package:pet_health_app/professionals.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final DataRepository repository = DataRepository();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeList(),
    Professionals(),
    Text('Forum')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ApplicationBlock(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pet Health'),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.logout_outlined),
                label: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'My Pets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Profeesionals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Forum',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent[800],
            onTap: _onItemTapped,
          ),
        ));
  }
}
