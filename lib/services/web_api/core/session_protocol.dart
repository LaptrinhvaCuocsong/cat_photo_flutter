import 'package:dio/dio.dart';
import 'package:template_flutter_app/business_logic/helper/constants.dart';
import 'package:template_flutter_app/business_logic/model/mapables/mapable.dart';
import 'package:template_flutter_app/services/web_api/core/api_result.dart';
import 'package:template_flutter_app/services/web_api/core/request_protocol.dart';

mixin HttpSessionProtocol {
  Future<APIResult<Mapable>> request(
      HttpRequestProtocol service, Mapable responseType);
}

class APISession with HttpSessionProtocol {
  Dio _dio;

  APISession() {
    initDio();
  }

  void initDio() {
    BaseOptions options = BaseOptions(
        connectTimeout: Constant.DURATION_REQUEST_TIMEOUT,
        receiveTimeout: Constant.DURATION_REQUEST_TIMEOUT);
    _dio = Dio(options);
  }

  @override
  Future<APIResult<Mapable>> request(
      HttpRequestProtocol service, Mapable responseType) async {
    try {
      Response response = await _dio.request(service.realUrl,
          data: service.isGetMethod ? null : service.params,
          queryParameters: service.isGetMethod ? service.params : null,
          options:
              Options(method: service.method.value, headers: service.headers));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var data = response.data;
        if (data != null) {
          return APIResult<Mapable>(
              data: Mapable(responseType, data), error: null);
        } else {
          return APIResult<Mapable>(data: null, error: APIError.unknown);
        }
      } else {
        return APIResult<Mapable>(
            data: null,
            error: APIError(
                code: response.statusCode, message: response.statusMessage));
      }
    } catch (e) {
      return APIResult<Mapable>(data: null, error: APIError.unknown);
    }
  }
}
