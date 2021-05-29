class HttpMethod {
  static HttpMethod postMethod = HttpMethod('post');
  static HttpMethod getMethod = HttpMethod('get');
  static HttpMethod putMethod = HttpMethod('put');
  static HttpMethod deleteMethod = HttpMethod('delete');

  final String value;

  HttpMethod(this.value);
}

mixin HttpRequestProtocol {
  String get baseUrl;
  String get path;
  HttpMethod get method;
  Map<String, String> get headers;
  Map<String, dynamic> get params;

  String get realUrl {
    return '$baseUrl$path';
  }

  bool get isGetMethod {
    return method.value == HttpMethod.getMethod.value;
  }
}
