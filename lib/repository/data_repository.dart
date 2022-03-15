import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/models/vaccination.dart';

import '../models/pet.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('pet');

  // 2
  DocumentReference profileImageRef =
      FirebaseFirestore.instance.collection('pet').doc();

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // 3
  Future<DocumentReference> addPet(Pet pet) {
    return collection.add(pet.toJson());
  }

  // 4
  void updatePet(Pet pet) async {
    await collection.doc(pet.referenceId).update(pet.toJson());
  }

  void updateVaccin(Pet pet, int index) async {
    await collection
        .doc(pet.referenceId)
        .update(pet.vaccinations[index].toJson());
  }

  // 5
  void deletePet(Pet pet) async {
    await collection.doc(pet.referenceId).delete();
  }

  //await saveImages(_images,sightingRef);

}
