// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trainee _$TraineeFromJson(Map<String, dynamic> json) => Trainee(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      contactNumber: json['contact_number'] as String,
      school: json['school'] as String?,
      office: json['office'] as String?,
      designation: json['designation'] as String?,
      yearLevel: json['year_level'] as int?,
    )..course = json['course'] as String?;

Map<String, dynamic> _$TraineeToJson(Trainee instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'contact_number': instance.contactNumber,
      'email': instance.email,
      'school': instance.school,
      'course': instance.course,
      'office': instance.office,
      'designation': instance.designation,
      'year_level': instance.yearLevel,
    };
