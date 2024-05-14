import 'package:json_annotation/json_annotation.dart';

part 'voucher.g.dart';

@JsonSerializable(
    includeIfNull: false
)
class Voucher {
  final int? id;

  @JsonKey(name: "voucher_code")
  String voucherCode;

  @JsonKey(name: "percent_off")
  double? percentOff;

  Voucher({
    this.id,
    required this.voucherCode,
    this.percentOff
    
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => _$VoucherFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherToJson(this);
}
