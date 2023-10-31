import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';


@JsonSerializable()
class Item {
  final String? title;
  final DateTime? time;

  Item({
    this.title,
    time,
  }) : time = time ?? DateTime.now();

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

