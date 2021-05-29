abstract class Mapable {
  factory Mapable(Mapable type, dynamic data) {
    if (type is BaseMapable) {
      return type.fromData(data);
    } else if (type is ListBaseMapable && data is List) {
      return type.fromListData(data);
    }

    return null;
  }
}

abstract class BaseMapable implements Mapable {
  Mapable fromData(dynamic data);
}

abstract class ListBaseMapable implements Mapable {
  Mapable fromListData(List<dynamic> data);
}
