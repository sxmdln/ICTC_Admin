// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trainee _$TraineeFromJson(Map<String, dynamic> json) => Trainee(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      contactNumber: json['contact_number'] as String?,
      school: json['school'] as String?,
      office: json['office'] as String?,
      designation: json['designation'] as String?,
      yearLevel: json['year_level'] as int?,
      uuid: json['uuid'] as String?,
    )..course = json['course'] as String?;

Map<String, dynamic> _$TraineeToJson(Trainee instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'first_name': instance.firstName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('middle_name', instance.middleName);
  val['last_name'] = instance.lastName;
  writeNotNull('contact_number', instance.contactNumber);
  val['email'] = instance.email;
  writeNotNull('school', instance.school);
  writeNotNull('course', instance.course);
  writeNotNull('office', instance.office);
  writeNotNull('designation', instance.designation);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('year_level', instance.yearLevel);
  return val;
}
