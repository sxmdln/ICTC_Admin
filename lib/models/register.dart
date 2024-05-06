import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable(
    includeIfNull: false
)
class Register {
  final int? id;

  @JsonKey(name: 'student_id')
  int studentId;

  @JsonKey(name: 'course_id')
  int courseId;

  @JsonKey(name: 'is_approved')
  bool status;


  Register({
    this.id,
    required this.studentId,
    required this.courseId,
    required this.status,

  });

  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
