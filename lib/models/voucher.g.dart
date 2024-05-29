// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) => Voucher(
      id: json['id'] as int?,
      voucherCode: json['voucher_code'] as String,
      percentOff: (json['percent_off'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VoucherToJson(Voucher instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['voucher_code'] = instance.voucherCode;
  writeNotNull('percent_off', instance.percentOff);
  return val;
}
