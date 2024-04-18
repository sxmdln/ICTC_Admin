import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  int id;

  @JsonKey(name: 'program_id')
  int programId;

  @JsonKey(name: 'trainer_id')
  int? trainerId;

  String title;
  String? description;
  int cost;
  String duration;
  String schedule;
  String venue;

  Course({
    required this.id,
    required this.programId,
    this.trainerId,
    required this.title,
    this.description,
    required this.cost,
    required this.duration,
    required this.schedule,
    required this.venue,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
