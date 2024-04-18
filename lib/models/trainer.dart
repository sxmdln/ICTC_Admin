import 'package:json_annotation/json_annotation.dart';

part 'trainer.g.dart';

@JsonSerializable()
class Trainer {
  int id;

  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "middle_name")
  String middleName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "contact_number")
  String contactNumber;

  String email;

  Trainer({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => _$TrainerFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerToJson(this);

  @override
  String toString() {
    return "$firstName $lastName";
  }
}
