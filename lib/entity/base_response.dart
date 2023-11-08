import 'package:flutter_example_test/entity/brand.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  final int? code;
  final Map<String, dynamic>? data;
  final bool? result;
  final String? message;

  const BaseResponse({
    this.code,
    this.data,
    this.result,
    this.message
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$BaseResponseFromJson(json);
}

