import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/data/pathtiledata.dart';
import 'package:nitnem/models/pathtile.dart';
import 'package:nitnem/navigation/appnavigator.dart';
import 'package:nitnem/providers/reader_provider.dart';
import 'package:nitnem/themes/themedata.dart';

class HomeScreen extends ConsumerWidget {
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
  Widget buildNitnemTile(BuildContext context, PathTile item, WidgetRef ref) {
    final theme = Theme.of(context);
    var listTile = ListTile(
      onTap: () {
        ref.read(readerProvider.notifier).setPath(
              id: item.id,
              title: item.title,
              filePrefix: item.filePrefix,
            );
        AppNavigator.goToReader(context);
      },
      dense: false,
      leading: const Text(
        '📖',
        style: TextStyle(fontSize: AppConstants.HOME_BOOK_ICON_SIZE),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontFamily: AppConstants.HOME_LISTITEM_FONT,
          fontSize: AppConstants.HOME_LISTITEM_FONT_SIZE,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.primaryColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_right,
          color: theme.primaryColor,
          size: 20,
        ),
      ),
      subtitle: Text(
        item.gurmukhi,
        style: TextStyle(
          fontFamily: AppConstants.HOME_LISTSUBITEM_FONT,
          fontSize: AppConstants.HOME_LISTSUBITEM_FONT_SIZE,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    return MergeSemantics(child: listTile);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    printInfoMessage('[BUILD] HomeScreen');
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    Iterable<Widget> listTiles = PathTileData.items.map<Widget>(
      (PathTile item) => buildNitnemTile(context, item, ref),
    );
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    return BackdropScaffold(
      key: _homeScreenScaffoldKey,
      backgroundColor: isDark ? kFlutterBlue : theme.primaryColor,
      appBar: BackdropAppBar(
        backgroundColor: theme.primaryColor,
        iconTheme: theme.primaryIconTheme,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Image.asset(
                'assets/images/floral-left.png',
                fit: BoxFit.fill,
                width: AppConstants.HOME_FLORAL_WIDTH,
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppConstants.HOME_TITLE_TEXT,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontFamily: AppConstants.HOME_TITLE_FONT,
                      fontSize: getTitleFontSize(context),
                      fontWeight: FontWeight.bold,
                      color: theme.primaryTextTheme.titleMedium?.color ??
                          Colors.white,
                    ),
                  ),
                ),
              ),
              new Image.asset(
                'assets/images/floral-right.png',
                fit: BoxFit.fill,
                width: AppConstants.HOME_FLORAL_WIDTH,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.bar_chart,
              color: theme.primaryIconTheme.color ?? Colors.white,
            ),
            onPressed: () => AppNavigator.goToStats(context),
          ),
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
            color: theme.primaryIconTheme.color ?? Colors.white,
          ),
        ],
      ),
      backLayer: optionsPage,
      frontLayer: SafeArea(
        bottom: true,
        child: Scrollbar(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: listTiles.toList(),
          ),
        ),
      ),
    );
  }
}
