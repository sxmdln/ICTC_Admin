// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      id: json['id'] as int?,
      studentId: json['student_id'] as int,
      courseId: json['course_id'] as int,
      status: json['is_approved'] as bool,
    );

Map<String, dynamic> _$RegisterToJson(Register instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['student_id'] = instance.studentId;
  val['course_id'] = instance.courseId;
  val['is_approved'] = instance.status;
  return val;
}
