// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as int?,
      discount: (json['discount'] as num?)?.toDouble(),
      studentId: json['student_id'] as int,
      programId: json['program_id'] as int,
      courseId: json['course_id'] as int,
      orNumber: json['official_receipt_number'] as String,
      orDate: DateTime.parse(json['official_receipt_date'] as String),
      totalAmount: (json['total_amount'] as num).toDouble(),
      approved: json['approved'] as bool,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['student_id'] = instance.studentId;
  val['program_id'] = instance.programId;
  val['course_id'] = instance.courseId;
  val['official_receipt_number'] = instance.orNumber;
  val['official_receipt_date'] = instance.orDate.toIso8601String();
  val['total_amount'] = instance.totalAmount;
  writeNotNull('discount', instance.discount);
  val['approved'] = instance.approved;
  return val;
}
