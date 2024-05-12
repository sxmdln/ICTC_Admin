import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'expense.g.dart';

@JsonSerializable(includeIfNull: false)
class Expense {
  final int? id;

  String particulars;

  @JsonKey(name: 'program_id')
  int? programId;

  Future<Program?> get program {
    return programId != null
        ? Supabase.instance.client
            .from('program')
            .select()
            .eq('id', programId!)
            .single()
            .withConverter((data) => Program.fromJson(data))
        : Future.value(null);
  }

  @JsonKey(name: 'course_id')
  int? courseId;

  Future<Course?> get course {
    return courseId != null
        ? Supabase.instance.client
            .from('course')
            .select()
            .eq('id', courseId!)
            .single()
            .withConverter((data) => Course.fromJson(data))
        : Future.value(null);
  }

  @JsonKey(name: 'official_receipt_number')
  String? orNumber;

  @JsonKey(name: 'official_receipt_date')
  DateTime? orDate;

  @JsonKey(name: 'total_amount')
  double amount;

  Expense({
    this.id,
    this.programId,
    this.courseId,
    this.orNumber,
    this.orDate,
    required this.particulars,
    required this.amount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
