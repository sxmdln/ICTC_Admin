import 'package:json_annotation/json_annotation.dart';

part 'program.g.dart';

@JsonSerializable()
class Program {
  int id;
  String title;
  String? description;

  Program({
    required this.id,
    required this.title,
    this.description,
  });

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}
