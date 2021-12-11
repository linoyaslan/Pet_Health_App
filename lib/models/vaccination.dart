import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccination {
  // 1
  final String vaccination;
  final DateTime date;
  bool? done;
  // 2
  Vaccination(this.vaccination, {required this.date, this.done});
  // 3
  factory Vaccination.fromJson(Map<String, dynamic> json) =>
      _vaccinationFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _vaccinationToJson(this);

  @override
  String toString() => 'Vaccination<$vaccination>';
}

// 1
Vaccination _vaccinationFromJson(Map<String, dynamic> json) {
  return Vaccination(
    json['vaccination'] as String,
    date: (json['date'] as Timestamp).toDate(),
    done: json['done'] as bool,
  );
}

// 2
Map<String, dynamic> _vaccinationToJson(Vaccination instance) =>
    <String, dynamic>{
      'vaccination': instance.vaccination,
      'date': instance.date,
      'done': instance.done,
    };
