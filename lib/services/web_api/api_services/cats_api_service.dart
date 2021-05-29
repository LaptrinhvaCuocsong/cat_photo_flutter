import 'package:template_flutter_app/services/web_api/core/api_result.dart';
import 'package:template_flutter_app/business_logic/model/cat_image.dart';
import 'package:template_flutter_app/business_logic/helper/enums.dart';

abstract class CatsAPIService {
  Future<APIResult<List<CatImage>>> fetchPublicCatsImage(
      int page, int limit, OrderBy order);
}
