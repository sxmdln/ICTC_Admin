// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
