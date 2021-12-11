import 'package:flutter/material.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/pet_profile.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/services/auth.dart';

class PetHome extends StatefulWidget {
  final Pet pet;
  const PetHome({Key? key, required this.pet}) : super(key: key);

  @override
  _PetHomeState createState() => _PetHomeState();
}

class _PetHomeState extends State<PetHome> {
  final AuthService _auth = AuthService();
  final DataRepository repository = DataRepository();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      PetProfile(pet: widget.pet),
      Text('Test'),
      Text('Test')
    ];
    return Scaffold(
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
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'To-Do',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.calendar_today),
          //   label: 'Calendar',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
