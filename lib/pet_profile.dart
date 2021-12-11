import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/pet_details.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:intl/intl.dart';
import 'models/pet.dart';
import 'repository/data_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as Path;

class PetProfile extends StatefulWidget {
  final Pet pet;
  const PetProfile({Key? key, required this.pet}) : super(key: key);

  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  final DataRepository repository = DataRepository();
  late DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  late String name;
  late String type;
  late String gender;
  String? profileImage;
  String? birthday;

  // ignore: unused_field
  late File _pickedImage;
  late String _uploadedFileURL;
  @override
  void initState() {
    type = widget.pet.type;
    name = widget.pet.name;
    profileImage = widget.pet.profileImage;
    gender = widget.pet.gender;
    birthday = widget.pet.birthday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueAccent, Colors.white])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: new IconButton(
                          icon: new Icon(Icons.edit),
                          color: Colors.white,
                          highlightColor: Colors.pink,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PetDetail(pet: widget.pet)));
                          },
                        ),
                      ),
                      CircleAvatar(
                        // backgroundImage: NetworkImage(
                        //   profileImage ??
                        //       'https://www.creativefabrica.com/wp-content/uploads/2020/09/01/Dog-paw-vector-icon-logo-design-heart-Graphics-5223218-1-1-580x387.jpg',
                        // ),
                        backgroundImage: Image.file(_pickedImage),
                        radius: 70.0,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: new IconButton(
                              icon: new Icon(Icons.add_a_photo),
                              color: Colors.white,
                              highlightColor: Colors.pink,
                              onPressed: () {
                                _showPickOptionsDialog(context);
                              },
                            )),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Type",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      type,
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.blueGrey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Gender",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      gender,
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.blueGrey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Birthday",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      birthday ?? '-',
                                      //(dateFormat.format(birthday!)),
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.blueGrey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.all(30),
              //padding: EdgeInsets.only(top: 24),
              alignment: Alignment.center,
              child: Column(children: [
                Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.medical_services,
                          size: 10,
                        ),
                        label: Text(
                          'Vaccin',
                          style: TextStyle(fontSize: 10),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.food_bank,
                          size: 10,
                        ),
                        label: Text(
                          'Food',
                          style: TextStyle(fontSize: 10),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.food_bank,
                          size: 10,
                        ),
                        label: Text(
                          'Hygiene',
                          style: TextStyle(fontSize: 10),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ]),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.food_bank,
                            size: 10,
                          ),
                          label: Text(
                            'Cleaning',
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.food_bank,
                            size: 10,
                          ),
                          label: Text(
                            'Medical',
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.food_bank,
                            size: 10,
                          ),
                          label: Text(
                            'General',
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                )
              ]))
          // Container(
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: 300.00,
          //   child: RaisedButton(
          //       onPressed: () {},
          //       // shape: RoundedRectangleBorder(
          //       //     borderRadius: BorderRadius.circular(80.0)),
          //       // elevation: 0.0,
          //       // padding: EdgeInsets.all(0.0),
          //       child: Ink(
          //         decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //               begin: Alignment.centerRight,
          //               end: Alignment.centerLeft,
          //               colors: [Colors.blueAccent, Colors.blueGrey]),
          //           borderRadius: BorderRadius.circular(80.0),
          //         ),
          //         child: Container(
          //           constraints:
          //               BoxConstraints(maxWidth: 100.0, minHeight: 100.0),
          //           alignment: Alignment.center,
          //           child: Text(
          //             "Vaccinations",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 11.0,
          //                 fontWeight: FontWeight.w300),
          //           ),
          //         ),
          //       )),
          // ),
        ],
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    File picked = (await ImagePicker().pickImage(source: source)) as File;
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
    Navigator.pop(context);
    uploadImageToFirebase();
  }

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      title: Text("Pick from Gallery"),
                      onTap: () async {
                        //File image = (await ImagePicker()
                        //    .pickImage(source: ImageSource.gallery)) as File;
                        _loadPicker(ImageSource.gallery);
                      }),
                  ListTile(
                      title: Text("Take a pictuer"),
                      onTap: () {
                        _loadPicker(ImageSource.camera);
                      })
                ],
              ),
            ));
  }

  Future uploadImageToFirebase() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_pickedImage.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_pickedImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }
}
