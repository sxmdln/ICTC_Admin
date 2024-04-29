import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable(
    includeIfNull: false
)
class Course {
  final int? id;

  @JsonKey(name: 'program_id')
  int? programId;

  @JsonKey(name: 'trainer_id')
  int? trainerId;

  String? title;
  String? description;
  int? cost;
  String? duration;
  String? schedule;
  String? venue;

  Course({
    this.id,
    required this.programId,
    this.trainerId,
    this.title,
    this.description,
    this.cost,
    this.duration,
    this.schedule,
    this.venue,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
