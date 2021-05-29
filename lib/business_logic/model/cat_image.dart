import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter_app/business_logic/model/cat_category.dart';

part 'cat_image.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CatImage {
  final List<CatCategory> categories;
  final String id;
  final String url;
  final int width;
  final int height;

  CatImage({this.categories, this.id, this.url, this.width, this.height});

  factory CatImage.fromJson(Map<String, dynamic> json) =>
      _$CatImageFromJson(json);

  Map<String, dynamic> toJson() => _$CatImageToJson(this);
}
