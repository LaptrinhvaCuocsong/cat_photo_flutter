import 'package:template_flutter_app/business_logic/helper/constants.dart';

class APIResult<T> {
  final T data;
  final APIError error;

  APIResult({this.data, this.error});

  bool get hasData {
    return data != null;
  }

  bool get hasError {
    return error != null;
  }
}

class APIError {
  static APIError unknown =
      APIError(code: -1, message: Constant.API_ERROR_MESSAGE);

  final int code;
  final String message;

  APIError({this.code, this.message});
}
