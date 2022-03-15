import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/Hygiene/bath_list.dart';
import 'package:pet_health_app/models/vaccination.dart';
import 'package:pet_health_app/models/bath.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'vaccination.dart';

class Pet {
  String name;
  String? uid;
  String? notes;
  String type;
  List<Vaccination> vaccinations;
  List<Bath> bathes;
  String? referenceId;
  String? profileImage;
  String gender;
  DateTime birthday;

  Pet(this.name,
      {this.notes,
      this.uid,
      required this.type,
      this.referenceId,
      this.profileImage =
          'https://www.creativefabrica.com/wp-content/uploads/2020/09/01/Dog-paw-vector-icon-logo-design-heart-Graphics-5223218-1-1-580x387.jpg',
      required this.vaccinations,
      required this.bathes,
      required this.gender,
      required this.birthday});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Pet.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) => _petFromJson(json);

  Map<String, dynamic> toJson() => _petToJson(this);

  @override
  String toString() => 'Pet<$name>';
}

Pet _petFromJson(Map<String, dynamic> json) {
  return Pet(json['name'] as String,
      notes: json['notes'] as String?,
      type: json['type'] as String,
      birthday: (json['birthday'] as Timestamp).toDate(),
      gender: json['gender'] as String,
      profileImage: json['profileImage'] as String?,
      uid: json['uid'] as String?,
      vaccinations: _convertVaccinations(json['vaccinations'] as List<dynamic>),
      bathes: _convertBathes(json['bathes'] as List<dynamic>));
}

List<Vaccination> _convertVaccinations(List<dynamic> vaccinationMap) {
  final vaccinations = <Vaccination>[];

  for (final vaccination in vaccinationMap) {
    vaccinations.add(Vaccination.fromJson(vaccination as Map<String, dynamic>));
  }
  return vaccinations;
}

List<Bath> _convertBathes(List<dynamic> bathMap) {
  final bathes = <Bath>[];

  for (final bath in bathMap) {
    bathes.add(Bath.fromJson(bath as Map<String, dynamic>));
  }
  return bathes;
}

Map<String, dynamic> _petToJson(Pet instance) => <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'type': instance.type,
      'profileImage': instance.profileImage,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'uid': instance.uid,
      'vaccinations': _vaccinationList(instance.vaccinations),
      'bathes': _bathList(instance.bathes),
    };

List<Map<String, dynamic>>? _vaccinationList(List<Vaccination>? vaccinations) {
  if (vaccinations == null) {
    return null;
  }
  final vaccinationMap = <Map<String, dynamic>>[];
  vaccinations.forEach((vaccination) {
    vaccinationMap.add(vaccination.toJson());
  });
  return vaccinationMap;
}

List<Map<String, dynamic>>? _bathList(List<Bath>? bathes) {
  if (bathes == null) {
    return null;
  }
  final bathMap = <Map<String, dynamic>>[];
  bathes.forEach((bath) {
    bathMap.add(bath.toJson());
  });
  return bathMap;
}

// class Pet {
//   final String uid;
//   final String pid;
//   String name;
//   String species;
//   String gender;
//   String breed;
//   DateTime birthday;
//   String profileImage;
//   String? notes;
//   List<Vaccination> vaccinations;

//   Pet(String json,
//       {
//       required this.uid,
//       required this.pid,
//       required this.name,
//       required this.species,
//       required this.gender,
//       required this.breed,
//       required this.birthday,
//       required this.profileImage,
//       required this.notes,
//       required this.vaccinations
//       });

//   factory Pet.fromJson(Map<String, dynamic> json) => _petFromJson(json);

//   String? get referenceId => null;

//   Map<String, dynamic> toJson() => _petToJson(this);

//   @override
//   String toString() => 'Pet<$pid>';
// }

// Pet _petFromJson(Map<String, dynamic> json) {
//   return Pet(json['pid'] as String,
//       uid: json['uid'] as String,
//       name: json['name'] as String,
//       species: json['species'] as String,
//       gender: json['gender'] as String,
//       breed: json['breed'] as String,
//       birthday: (json['birthday'] as Timestamp).toDate(),
//       pid: '',
//       profileImage: json['profileImage'] as String,
//       notes: json['notes'] as String,
//       vaccinations:
//           _convertVaccinations(json['vaccinations'] as List<dynamic>));
// }

// List<Vaccination> _convertVaccinations(List<dynamic> vaccinationMap) {
//   final vaccinations = <Vaccination>[];

//   for (final vaccination in vaccinationMap) {
//     vaccinations.add(Vaccination.fromJson(vaccination as Map<String, dynamic>));
//   }
//   return vaccinations;
// }

// // 2
// Map<String, dynamic> _petToJson(Pet instance) => <String, dynamic>{
//       "uid": instance.uid,
//       "pid": instance.pid,
//       "name": instance.name,
//       "species": instance.species,
//       "gender": instance.gender,
//       "breed": instance.breed,
//       "birthday": instance.birthday,
//       "profileImage": instance.profileImage,
//       "notes": instance.notes,
//       'vaccinations': _vaccinationList(instance.vaccinations),
//     };

// List<Map<String, dynamic>>? _vaccinationList(List<Vaccination>? vaccinations) {
//   if (vaccinations == null) {
//     return null;
//   }
//   final vaccinationMap = <Map<String, dynamic>>[];
//   vaccinations.forEach((vaccination) {
//     vaccinationMap.add(vaccination.toJson());
//   });
//   return vaccinationMap;
// }
