import 'package:template_flutter_app/business_logic/helper/constants.dart';
import 'package:template_flutter_app/business_logic/helper/enums.dart';
import 'package:template_flutter_app/services/web_api/core/request_protocol.dart';

enum CatApiVersion { v1 }

String $CatApiVersionToString(CatApiVersion version) {
  switch (version) {
    case CatApiVersion.v1:
      return 'v1';
    default:
      return '';
  }
}

class CatApiRequest with HttpRequestProtocol {
  String get baseUrl => Endpoint.CAT_API_ENDPOINT;
  String get path => '';
  HttpMethod get method => HttpMethod.getMethod;
  Map<String, String> get headers =>
      {'Content-Type': 'application/json', 'x-api-key': APIKey.CAT_API_KEY};
  Map<String, dynamic> get params => null;

  CatApiVersion get currentVersion => CatApiVersion.v1;

  @override
  String get realUrl =>
      '$baseUrl${$CatApiVersionToString(currentVersion)}/$path';
}

class GetPublicCatImageRequest extends CatApiRequest {
  final int page;
  final int limit;
  final OrderBy orderBy;

  GetPublicCatImageRequest({this.page, this.limit, this.orderBy});

  @override
  String get path => 'images/search';

  @override
  Map<String, dynamic> get params =>
      {'page': page, 'limit': limit, 'order': $OrderByToString(orderBy)};
}
