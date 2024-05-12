// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as int,
      programId: json['program_id'] as int,
      courseId: json['course_id'] as int,
      totalAmount: (json['total_amount'] as num).toDouble(),
      orNumber: json['official_receipt_number'] as String,
      orDate: DateTime.parse(json['official_receipt_date'] as String),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'program_id': instance.programId,
      'course_id': instance.courseId,
      'total_amount': instance.totalAmount,
      'official_receipt_number': instance.orNumber,
      'official_receipt_date': instance.orDate.toIso8601String(),
    };
