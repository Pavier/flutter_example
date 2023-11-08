import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable()
class Brand {
  final List<BrandList>? list;

  const Brand({
    this.list,
  });

  factory Brand.fromJson(Map<String, dynamic> json) =>
      _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class BrandList {
  final String? companyCode;
  final String? companyName;
  final String? logo;

  const BrandList({
    this.companyCode,
    this.companyName,
    this.logo,
  });

  factory BrandList.fromJson(Map<String, dynamic> json) =>
      _$BrandListFromJson(json);

  Map<String, dynamic> toJson() => _$BrandListToJson(this);
}
