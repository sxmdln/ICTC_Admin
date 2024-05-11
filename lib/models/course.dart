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

  // TODO: set nullable and not nullable variables
  String title;
  String? description;
  int cost;
  String? duration;
  String? schedule;
  String? venue;
  
  @JsonKey(name: 'start_date')
  DateTime? startDate;

  @JsonKey(name: 'end_date')
  DateTime? endDate;

  var students;

  Course({
    this.id,
    required this.programId,
    required this.trainerId,
    required this.title,
    this.description,
    required this.cost,
    this.duration,
    this.schedule,
    this.venue,
    this.startDate,
    this.endDate,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  String toString() {
    return title;
  }
}
