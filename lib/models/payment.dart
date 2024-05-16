import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'payment.g.dart';

@JsonSerializable(includeIfNull: false)
class Payment {
  final int? id;

  @JsonKey(name: 'student_id')
  int studentId;

  Future<Trainee> get student => Supabase.instance.client
      .from('student')
      .select()
      .eq('id', studentId)
      .single()
      .withConverter((data) => Trainee.fromJson(data));

  @JsonKey(name: 'program_id')
  int programId;

  Future<Program> get program => Supabase.instance.client
      .from('program')
      .select()
      .eq('id', programId)
      .single()
      .withConverter((data) => Program.fromJson(data));

  @JsonKey(name: 'course_id')
  int courseId;

  Future<Course> get course => Supabase.instance.client
      .from('course')
      .select()
      .eq('id', courseId)
      .single()
      .withConverter((data) => Course.fromJson(data));

  @JsonKey(name: 'official_receipt_number')
  String orNumber;

  @JsonKey(name: 'official_receipt_date')
  DateTime orDate;

  @JsonKey(name: 'total_amount')
  double totalAmount;

  double? discount;
  bool approved;

  Payment(
      {this.id,
      this.discount,
      required this.studentId,
      required this.programId,
      required this.courseId,
      required this.orNumber,
      required this.orDate,
      required this.totalAmount,
      required this.approved});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override
  String toString() {
    return "Payment #$id";
  }
}
