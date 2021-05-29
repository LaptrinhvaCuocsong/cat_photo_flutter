import 'package:template_flutter_app/business_logic/model/cat_image.dart';
import 'package:template_flutter_app/business_logic/model/mapables/mapable.dart';

class ListCatMapable extends ListBaseMapable {
  List<CatImage> cats;

  @override
  Mapable fromListData(List<dynamic> data) {
    cats = data
        .cast<Map<String, dynamic>>()
        .map((e) => CatImage.fromJson(e))
        .toList();
    return this;
  }
}
