// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as int?,
      programId: json['program_id'] as int,
      trainerId: json['trainer_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      cost: json['cost'] as int?,
      duration: json['duration'] as String?,
      schedule: json['schedule'] as String?,
      venue: json['venue'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['program_id'] = instance.programId;
  writeNotNull('trainer_id', instance.trainerId);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('cost', instance.cost);
  writeNotNull('duration', instance.duration);
  writeNotNull('schedule', instance.schedule);
  writeNotNull('venue', instance.venue);
  return val;
}
