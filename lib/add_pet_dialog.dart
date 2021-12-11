import 'package:flutter/material.dart';

import 'models/pet.dart';
import 'repository/data_repository.dart';
import 'widgets/choose_chips.dart';

class AddPetDialog extends StatefulWidget {
  //final Pet pet;
  const AddPetDialog({Key? key}) : super(key: key);

  @override
  _AddPetDialogState createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  String? petName;
  String character = '';
  String characterGender = '';

  late List<CategoryOption> genderTypes;
  late String gender;

  final DataRepository repository = DataRepository();

  @override
  void initState() {
    gender = '';
    genderTypes = [
      CategoryOption(type: 'Male', name: 'Male', isSelected: gender == 'Male'),
      CategoryOption(
          type: 'Female', name: 'Female', isSelected: gender == 'Female'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Pet'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // ChooseType(
              //   title: 'Gender',
              //   options: genderTypes,
              //   onOptionTap: (value) {
              //     setState(() {
              //       genderTypes.forEach((element) {
              //         gender = value.type;
              //         element.isSelected = element.type == value.type;
              //       });
              //     });
              //   },
              // ),
              RadioListTile(
                title: const Text('Male'),
                value: 'Male',
                groupValue: characterGender,
                onChanged: (value) {
                  setState(() {
                    characterGender = (value ?? '') as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Female'),
                value: 'Female',
                groupValue: characterGender,
                onChanged: (value) {
                  setState(() {
                    characterGender = (value ?? '') as String;
                  });
                },
              ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a Pet Name'),
                onChanged: (text) => petName = text,
              ),
              RadioListTile(
                title: const Text('Cat'),
                value: 'cat',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Dog'),
                value: 'dog',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Other'),
                value: 'other',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                if (petName != null && character.isNotEmpty) {
                  final newPet = Pet(petName!,
                      type: character,
                      gender: characterGender,
                      vaccinations: []);
                  repository.addPet(newPet);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add')),
        ]);
  }
}
