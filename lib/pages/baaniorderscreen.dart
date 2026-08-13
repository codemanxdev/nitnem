import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/models/pathtile.dart';
import 'package:nitnem/navigation/appnavigator.dart';
import 'package:nitnem/providers/settings_provider.dart';

import '../data/pathtiledata.dart';

class BaaniOrderScreen extends ConsumerWidget {
  BaaniOrderScreen({required Key key}) : super(key: key);

  static final GlobalKey<ScaffoldState> _baaniOrderScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  Widget buildNitnemTile(BuildContext context, PathTile item) {
    var listTile = ListTile(
      key: ValueKey(item.id),
      onTap: () => (),
      dense: false,
      leading: const Text(
        '📖',
        style: TextStyle(fontSize: AppConstants.HOME_BOOK_ICON_SIZE),
      ),
      title: Text(
        item.title,
        style: new TextStyle(
          fontFamily: AppConstants.HOME_LISTITEM_FONT,
          fontSize: AppConstants.HOME_LISTITEM_FONT_SIZE,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(Icons.reorder),
      subtitle: Text(
        item.gurmukhi,
        style: new TextStyle(
          fontFamily: AppConstants.HOME_LISTSUBITEM_FONT,
          fontSize: AppConstants.HOME_LISTSUBITEM_FONT_SIZE,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    return listTile;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    printInfoMessage('[BUILD] BaaniOrderScreen');
    final ThemeData theme = Theme.of(context);

    // Watch settings to trigger rebuild if needed, but primarily we manipulate PathTileData.items
    ref.watch(settingsProvider);

    Iterable<Widget> listTiles = PathTileData.items.map<Widget>(
      (PathTile item) => buildNitnemTile(context, item),
    );

    return Scaffold(
      key: _baaniOrderScreenScaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        iconTheme: theme.primaryIconTheme,
        centerTitle: true,
        title: const Text("Change Baani Order"),
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              // Reorder based on original order IDs
              final idToItem = {
                for (var item in PathTileData.items) item.id: item,
              };
              List<PathTile> originalOrder =
                  PathTileData.defaultOrderIds.map((id) => idToItem[id]!).toList();
              PathTileData.items = originalOrder;

              ref.read(settingsProvider.notifier).resetBaaniOrder();
            },
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              List<dynamic> itemIds =
                  PathTileData.items.map((item) => item.id).toList();
              ref.read(settingsProvider.notifier).updateBaaniOrder(itemIds);
              AppNavigator.goBack(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Scrollbar(
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            onReorderItem: (int oldIndex, int newIndex) {
              if (newIndex > oldIndex) newIndex -= 1;
              final element = PathTileData.items.removeAt(oldIndex);
              PathTileData.items.insert(newIndex, element);
              printInfoMessage(
                "Baani Order Changed To: ${PathTileData.items}",
              );
              // Trigger a local rebuild to show the new order
              // In a real app, PathTileData.items should probably be in a provider too
              // but keeping current logic of static list manipulation for now
              (context as Element).markNeedsBuild();
            },
            children: listTiles.toList(),
          ),
        ),
      ),
    );
  }
}
