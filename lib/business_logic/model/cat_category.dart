import 'package:json_annotation/json_annotation.dart';

part 'cat_category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CatCategory {
  final int id;
  final String name;

  CatCategory({this.id, this.name});

  factory CatCategory.fromJson(Map<String, dynamic> json) =>
      _$CatCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CatCategoryToJson(this);
}
