// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      json['name'] as String,
      notes: json['notes'] as String?,
      uid: json['uid'] as String?,
      type: json['type'] as String,
      referenceId: json['referenceId'] as String?,
      profileImage: json['profileImage'] as String? ??
          'https://www.creativefabrica.com/wp-content/uploads/2020/09/01/Dog-paw-vector-icon-logo-design-heart-Graphics-5223218-1-1-580x387.jpg',
      vaccinations: (json['vaccinations'] as List<dynamic>)
          .map((e) => Vaccination.fromJson(e as Map<String, dynamic>))
          .toList(),
      bathes: (json['bathes'] as List<dynamic>)
          .map((e) => Bath.fromJson(e as Map<String, dynamic>))
          .toList(),
      teeth: (json['teeth'] as List<dynamic>)
          .map((e) => Teeth.fromJson(e as Map<String, dynamic>))
          .toList(),
      gender: json['gender'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      gallery:
          (json['gallery'] as List<dynamic>?)?.map((e) => e as String).toList(),
      weight: (json['weight'] as List<dynamic>?)
          ?.map((e) => Weight.fromJson(e as Map<String, dynamic>))
          .toList(),
      height: (json['height'] as List<dynamic>?)
          ?.map((e) => Height.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'notes': instance.notes,
      'type': instance.type,
      'vaccinations': instance.vaccinations.map((e) => e.toJson()).toList(),
      'bathes': instance.bathes.map((e) => e.toJson()).toList(),
      'teeth': instance.teeth.map((e) => e.toJson()).toList(),
      'referenceId': instance.referenceId,
      'profileImage': instance.profileImage,
      'gender': instance.gender,
      'birthday': instance.birthday.toIso8601String(),
      'gallery': instance.gallery,
      'weight': instance.weight?.map((e) => e.toJson()).toList(),
      'height': instance.height?.map((e) => e.toJson()).toList(),
    };
