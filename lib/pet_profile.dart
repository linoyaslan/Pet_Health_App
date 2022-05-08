import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_health_app/cleaning_home.dart';
import 'package:pet_health_app/general_home.dart';
import 'package:pet_health_app/hygiene_home.dart';
import 'package:pet_health_app/medical_home.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/vaccination.dart';
import 'package:pet_health_app/pet_details.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/vaccination_list.dart';
import 'models/pet.dart';
import 'repository/data_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter_svg/flutter_svg.dart';

class PetProfile extends StatefulWidget {
  final Pet pet;
  const PetProfile({Key? key, required this.pet}) : super(key: key);

  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  final DataRepository repository = DataRepository();
  final _formKey = GlobalKey<FormState>();
  late DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  late String name;
  late String type;
  late String gender;
  String? profileImage;
  late String birthday;
  late String date;
  // ignore: unused_field
  late XFile? _pickedImage;
  late String _uploadedFileURL;
  @override
  void initState() {
    type = widget.pet.type;
    name = widget.pet.name;
    profileImage = widget.pet.profileImage;
    gender = widget.pet.gender;
    birthday = dateFormat.format(widget.pet.birthday);
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
                      colors: [Colors.blue, Colors.white])),
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
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          profileImage ??
                              'https://www.creativefabrica.com/wp-content/uploads/2020/09/01/Dog-paw-vector-icon-logo-design-heart-Graphics-5223218-1-1-580x387.jpg',
                        ),
                        radius: 70.0,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: new IconButton(
                              icon: new Icon(Icons.add_a_photo),
                              color: Colors.white,
                              highlightColor: Colors.pink,
                              onPressed: () {
                                _showPickOptionsDialog(context);
                                //_uploadPhoto(mFileImage)
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
                                        color: Colors.blue[700],
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
                                        color: Colors.blue[700],
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
                                        color: Colors.blue[700],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    //                                      birthday ?? '-',
                                    Text(
                                      birthday,
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
              margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 55.0),
              alignment: Alignment.center,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.white,
                            child: Center(
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3, color: Colors.blue)),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/syringe-svgrepo-com.svg",
                                  ),
                                  iconSize: 50,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VaccinationList(
                                                    pet: widget.pet)));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text("Vaccination")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.white,
                            child: Center(
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3, color: Colors.blue)),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/dog-food-svgrepo-com.svg",
                                  ),
                                  iconSize: 50,
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                          Text("Food")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.white,
                            child: Center(
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3, color: Colors.blue)),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/pet-first-aid-svgrepo-com.svg",
                                  ),
                                  iconSize: 50,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MedicalHome(pet: widget.pet)));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text("Medical")
                        ],
                      ),
                    ),
                  ]),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.white,
                            child: Center(
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3, color: Colors.blue)),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/mop-water-bucket-and-cleaning-spray-svgrepo-com.svg",
                                  ),
                                  iconSize: 50,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CleaningHome()));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text("Cleaning")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.white,
                            child: Center(
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3, color: Colors.blue)),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/pet-lotion-svgrepo-com.svg",
                                  ),
                                  iconSize: 50,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HygieneHome(pet: widget.pet)));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text("Hygiene")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.white,
                            child: Center(
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3, color: Colors.blue)),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/paw-print-svgrepo-com.svg",
                                  ),
                                  iconSize: 50,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GeneralHome(pet: widget.pet)));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text("General")
                        ],
                      ),
                    ),
                  ],
                )
              ]))
        ],
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    final picker = ImagePicker();
    XFile? picked = await picker.pickImage(source: source, imageQuality: 50);

    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
    Navigator.pop(context);
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
                        await _loadPicker(ImageSource.gallery);
                        uploadImageToFirebase();
                      }),
                  ListTile(
                      title: Text("Take a picture"),
                      onTap: () async {
                        await _loadPicker(ImageSource.camera);
                        uploadImageToFirebase();
                      })
                ],
              ),
            ));
  }

  Future uploadImageToFirebase() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    File? file = File(_pickedImage!.path);
    Reference ref = storage.ref().child('profile/${Path.basename(file.path)}}');
    UploadTask uploadTask = ref.putFile(file);
    await uploadTask;
    ref.getDownloadURL().then((fileURL) {
      setState(() {
        profileImage = fileURL;
        widget.pet.profileImage = profileImage;
        repository.updatePet(widget.pet);
      });
    });
  }

  Future _uploadPhoto(mFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("profile");
    UploadTask uploadTask =
        storageReference.child("pet_$profileImage.jpg").putFile(mFileImage);

    String url = await (await uploadTask).ref.getDownloadURL();
    profileImage = url;
  }
}
