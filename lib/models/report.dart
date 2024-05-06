import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(includeIfNull: false)
class Report {
  final int id;

  @JsonKey(name: 'program_id')
  final int programId;

  @JsonKey(name: 'course_id')
  final int courseId;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'official_receipt_number')
  final String orNumber;

  @JsonKey(name: 'official_receipt_date')
  final DateTime orDate;

  Report(
      {required this.id,
      required this.programId,
      required this.courseId,
      required this.totalAmount,
      required this.orNumber,
      required this.orDate});

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
