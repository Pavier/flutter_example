// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => BrandList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'list': instance.list,
    };

BrandList _$BrandListFromJson(Map<String, dynamic> json) => BrandList(
      companyCode: json['companyCode'] as String?,
      companyName: json['companyName'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$BrandListToJson(BrandList instance) => <String, dynamic>{
      'companyCode': instance.companyCode,
      'companyName': instance.companyName,
      'logo': instance.logo,
    };
