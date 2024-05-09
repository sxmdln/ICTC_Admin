import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable(
    includeIfNull: false
)
class Register {

  final int? id;

  @JsonKey(name: 'student_id')
  int? studentId;

  @JsonKey(name: 'course_id')
  int? courseId;

  //String? status;

  bool is_approved;

  Register({
    this.id,
    required this.studentId,
    this.courseId,
    //this.status,
    required this.is_approved, 
  });

  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);

  @override
  String toString() {
    return '$studentId.firstName $studentId.lastName';
  }
}
