import 'package:template_flutter_app/business_logic/helper/enums.dart';
import 'package:template_flutter_app/business_logic/model/cat_image.dart';
import 'package:template_flutter_app/business_logic/model/mapables/cats_mapable.dart';
import 'package:template_flutter_app/business_logic/model/mapables/mapable.dart';
import 'package:template_flutter_app/services/web_api/api_services/cats_api_service.dart';
import 'package:template_flutter_app/services/web_api/core/api_result.dart';
import 'package:template_flutter_app/services/web_api/core/request_protocol.dart';
import 'package:template_flutter_app/services/web_api/core/session_protocol.dart';
import 'package:template_flutter_app/services/web_api/requests/cat_api_requests.dart';

class CatAPISession extends APISession implements CatsAPIService {
  Future<APIResult<List<CatImage>>> fetchPublicCatsImage(
      int page, int limit, OrderBy order) async {
    HttpRequestProtocol service =
        GetPublicCatImageRequest(page: page, limit: limit, orderBy: order);
    ListCatMapable listCatMapable = ListCatMapable();
    APIResult<Mapable> result = await request(service, listCatMapable);
    if (result.hasData) {
      return APIResult<List<CatImage>>(data: listCatMapable.cats, error: null);
    } else {
      return APIResult<List<CatImage>>(data: null, error: result.error);
    }
  }
}
