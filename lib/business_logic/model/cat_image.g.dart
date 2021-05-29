// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatImage _$CatImageFromJson(Map<String, dynamic> json) {
  return CatImage(
    categories: (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : CatCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as String,
    url: json['url'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
  );
}

Map<String, dynamic> _$CatImageToJson(CatImage instance) => <String, dynamic>{
      'categories': instance.categories,
      'id': instance.id,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
