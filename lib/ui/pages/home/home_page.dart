import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter_app/business_logic/helper/strings.dart';
import 'package:template_flutter_app/business_logic/model/cat_image.dart';
import 'package:template_flutter_app/ui/pages/home/home_viewmodel.dart';
import 'package:template_flutter_app/services/web_api/core/api_result.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:template_flutter_app/services/web_api/sessions/cat_api_session.dart';
import 'package:template_flutter_app/ui/components/dialog/msg_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  HomeViewModel _viewModel = HomeViewModel(CatAPISession());
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _viewModel.loadmore();
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _viewModel.fetchPublicCatsImage();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.homeTitle),
          centerTitle: true,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      if (viewModel.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        APIResult<List<CatImage>> response =
            viewModel.fetchPublicCatsImageResponse;

        if (response != null) {
          if (response.hasData) {
            return _buildGridView(viewModel.cats);
          }

          if (response.hasError) {
            MsgDialog.show(context, response.error.message);
          }
        }

        return _buildEmptyView();
      }
    });
  }

  Widget _buildGridView(List<CatImage> cats) {
    List<Widget> catCardViews = cats.map((e) => _buildCatCardView(e)).toList();
    List<StaggeredTile> catTiles =
        cats.map((e) => StaggeredTile.count(2, 2)).toList();

    return RefreshIndicator(
      onRefresh: _viewModel.fetchPublicCatsImage,
      child: StaggeredGridView.countBuilder(
        controller: _controller,
        crossAxisCount: 4,
        itemCount:
            _viewModel.loadmoreIsPossible ? cats.length + 1 : cats.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < cats.length) {
            return catCardViews[index];
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        staggeredTileBuilder: (int index) =>
            index == cats.length ? StaggeredTile.count(4, 1) : catTiles[index],
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget _buildCatCardView(CatImage cat) {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(8)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(cat.url))),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Text("Something Error ..."),
    );
  }
}
