import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/data/pathtiledata.dart';
import 'package:nitnem/models/pathtile.dart';
import 'package:nitnem/navigation/appnavigator.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:nitnem/state/appstate.dart';
import 'package:nitnem/themes/themedata.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required Key key, required this.optionsPage}) : super(key: key);

  final Widget optionsPage;

  static final GlobalKey<ScaffoldState> _homeScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  ///Determine title size based on resolution
  double getTitleFontSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width <= AppConstants.DEVICE_SMALL_RES) {
      return AppConstants.HOME_TITLE_FONT_SIZE_SMALL;
    } else {
      return AppConstants.HOME_TITLE_FONT_SIZE;
    }
  }

  ///Builds a nitnem paath line entry
  Widget buildNitnemTile(BuildContext context, PathTile item, _ViewModel vm) {
    var listTile = ListTile(
      onTap: () => vm.onPathClickAction(context, item),
      dense: false,
      leading: new Image.asset(
        'assets/images/book.png',
        fit: BoxFit.fill,
        width: 36,
      ),
      title: Text(
        item.title,
        style: new TextStyle(
          fontFamily: AppConstants.HOME_LISTITEM_FONT,
          fontSize: AppConstants.HOME_LISTITEM_FONT_SIZE,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: FaIcon(FontAwesomeIcons.circleRight),
      subtitle: Text(
        item.gurmukhi,
        style: new TextStyle(
          fontFamily: AppConstants.HOME_LISTSUBITEM_FONT,
          fontSize: AppConstants.HOME_LISTSUBITEM_FONT_SIZE,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    return MergeSemantics(child: listTile);
  }

  @override
  Widget build(BuildContext context) {
    printInfoMessage('[BUILD] HomeScreen');
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    var result = StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        Iterable<Widget> listTiles = PathTileData.items.map<Widget>(
          (PathTile item) => buildNitnemTile(context, item, vm),
        );
        listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
        return BackdropScaffold(
          key: _homeScreenScaffoldKey,
          backgroundColor: isDark ? kFlutterBlue : theme.primaryColor,
          appBar: BackdropAppBar(
            backgroundColor: theme.primaryColor,
            title: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: [
                  new Image.asset(
                    'assets/images/floral-left.png',
                    fit: BoxFit.fill,
                    width: AppConstants.HOME_FLORAL_WIDTH,
                  ),
                  Text(
                    AppConstants.HOME_TITLE_TEXT,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontFamily: AppConstants.HOME_TITLE_FONT,
                      fontSize: getTitleFontSize(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Image.asset(
                    'assets/images/floral-right.png',
                    fit: BoxFit.fill,
                    width: AppConstants.HOME_FLORAL_WIDTH,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            actions: <Widget>[
              BackdropToggleButton(icon: AnimatedIcons.list_view),
            ],
          ),
          backLayer: optionsPage,
          frontLayer: Scrollbar(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: listTiles.toList(),
            ),
          ),
        );
      },
    );
    return result;
  }
}

class _ViewModel {
  final void Function(BuildContext, PathTile) onPathClickAction;

  _ViewModel({required this.onPathClickAction});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onPathClickAction: (BuildContext ctx, PathTile path) {
        store.dispatch(
          FetchNitnemPathAction(path, store.state.options.languageName),
        );
        AppNavigator.goToReader(ctx);
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
