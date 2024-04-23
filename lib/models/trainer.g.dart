// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trainer _$TrainerFromJson(Map<String, dynamic> json) => Trainer(
      id: json['id'] as int?,
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      contactNumber: json['contact_number'] as String,
    );

Map<String, dynamic> _$TrainerToJson(Trainer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['first_name'] = instance.firstName;
  writeNotNull('middle_name', instance.middleName);
  val['last_name'] = instance.lastName;
  val['contact_number'] = instance.contactNumber;
  val['email'] = instance.email;
  return val;
}
