import 'package:flutter/material.dart';
import 'package:template_flutter_app/business_logic/helper/enums.dart';
import 'package:template_flutter_app/business_logic/model/cat_image.dart';
import 'package:template_flutter_app/services/web_api/api_services/cats_api_service.dart';
import 'package:template_flutter_app/services/web_api/core/api_result.dart';

class HomeViewModel extends ChangeNotifier {
  APIResult<List<CatImage>> fetchPublicCatsImageResponse;
  List<CatImage> cats;
  bool loadmoreIsPossible = true;
  bool _isLoading = false;
  bool _isLoadmore = false;
  CatsAPIService _catsService;
  int _page = 0;
  int _limit = 10;
  OrderBy _orderBy = OrderBy.asc;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  bool get isLoadmore {
    return _isLoadmore;
  }

  set isLoadmore(bool newValue) {
    _isLoadmore = newValue;
    notifyListeners();
  }

  HomeViewModel(this._catsService);

  Future<void> fetchPublicCatsImage() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    _page = 0;
    await _fetchPublicCatsImage();
  }

  Future<void> loadmore() async {
    if (isLoadmore) {
      return;
    }
    isLoadmore = true;
    _page += 1;
    await _fetchPublicCatsImage();
  }

  Future<void> _fetchPublicCatsImage() async {
    APIResult<List<CatImage>> response =
        await _catsService.fetchPublicCatsImage(_page, _limit, _orderBy);
    if (response.hasData) {
      if (_page == 0) {
        cats = [];
      }
      cats.addAll(response.data);
      loadmoreIsPossible = response.data.length == _limit;
    }
    fetchPublicCatsImageResponse = response;
    isLoading = false;
    isLoadmore = false;
    notifyListeners();
  }
}
