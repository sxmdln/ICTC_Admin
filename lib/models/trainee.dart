import 'package:json_annotation/json_annotation.dart';

part 'trainee.g.dart';

@JsonSerializable()
class Trainee {
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

  String? school;

  String? course;

  String? office;

  String? designation;

  @JsonKey(name: "year_level")
  int? yearLevel;

  Trainee({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    this.school,
    this.office,
    this.designation,
    this.yearLevel,
  });

  factory Trainee.fromJson(Map<String, dynamic> json) => _$TraineeFromJson(json);

  Map<String, dynamic> toJson() => _$TraineeToJson(this);

  @override
  String toString() {
    return "$firstName $lastName";
  }

  // double totalTrainees(){
  //   double total = 0.0;
  //   for(Trainee trainee in Trainee){
  //     total += product.price * product.quantity;
  //   }
  //   return total;
  // }
}
