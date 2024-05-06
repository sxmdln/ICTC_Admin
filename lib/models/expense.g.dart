// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      id: json['id'] as int?,
      programId: json['program_id'] as int?,
      courseId: json['course_id'] as int?,
      orNumber: json['official_receipt_number'] as String?,
      orDate: json['official_receipt_date'] == null
          ? null
          : DateTime.parse(json['official_receipt_date'] as String),
      particulars: json['particulars'] as String,
      amount: (json['total_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['particulars'] = instance.particulars;
  writeNotNull('program_id', instance.programId);
  writeNotNull('course_id', instance.courseId);
  writeNotNull('official_receipt_number', instance.orNumber);
  writeNotNull('official_receipt_date', instance.orDate?.toIso8601String());
  val['total_amount'] = instance.amount;
  return val;
}
