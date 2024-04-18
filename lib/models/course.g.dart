// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as int,
      programId: json['program_id'] as int,
      trainerId: json['trainer_id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String?,
      cost: json['cost'] as int,
      duration: json['duration'] as String,
      schedule: json['schedule'] as String,
      venue: json['venue'] as String,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'program_id': instance.programId,
      'trainer_id': instance.trainerId,
      'title': instance.title,
      'description': instance.description,
      'cost': instance.cost,
      'duration': instance.duration,
      'schedule': instance.schedule,
      'venue': instance.venue,
    };
