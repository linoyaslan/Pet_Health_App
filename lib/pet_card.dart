import 'package:flutter/material.dart';
import 'pet_room.dart';
import 'models/pet.dart';
import 'utils/pet_icons.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final TextStyle boldStyle;
  final splashColor = {
    'cat': Colors.pink[100],
    'dog': Colors.blue[100],
    'other': Colors.grey[100]
  };

  PetCard({Key? key, required this.pet, required this.boldStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(pet.name, style: boldStyle)),
          ),
          _getPetIcon(pet.type)
        ],
      ),
      onTap: () => Navigator.push<Widget>(
        context,
        MaterialPageRoute(
          builder: (context) => PetRoom(pet: pet),
        ),
      ),
      splashColor: splashColor[pet.type],
    ));
  }

  Widget _getPetIcon(String type) {
    Widget petIcon;
    if (type == 'cat') {
      petIcon = IconButton(
        icon: const Icon(
          //Pets.cat,
          Icons.pets,
          color: Colors.pinkAccent,
        ),
        onPressed: () {},
      );
    } else if (type == 'dog') {
      petIcon = IconButton(
        icon: const Icon(
          //Pets.dog_seating,
          Icons.pets,
          color: Colors.blueAccent,
        ),
        onPressed: () {},
      );
    } else {
      petIcon = IconButton(
        icon: const Icon(
          Icons.pets,
          color: Colors.blueGrey,
        ),
        onPressed: () {},
      );
    }
    return petIcon;
  }
}
