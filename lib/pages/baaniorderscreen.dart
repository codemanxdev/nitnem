import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/models/pathtile.dart';
import 'package:nitnem/navigation/appnavigator.dart';
import 'package:redux/redux.dart';

import '../data/pathtiledata.dart';
import '../redux/actions/actions.dart';
import '../state/appstate.dart';

class BaaniOrderScreen extends StatelessWidget {
  BaaniOrderScreen({required Key key}) : super(key: key);

  static final GlobalKey<ScaffoldState> _baaniOrderScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  Widget buildNitnemTile(BuildContext context, PathTile item) {
    var listTile = ListTile(
      key: UniqueKey(),
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
      trailing: Icon(Icons.reorder),
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
  Widget build(BuildContext context) {
    printInfoMessage('[BUILD] HomeScreen');
    final ThemeData theme = Theme.of(context);

    Iterable<Widget> listTiles = PathTileData.items.map<Widget>(
      (PathTile item) => buildNitnemTile(context, item),
    );

    var result = StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          key: _baaniOrderScreenScaffoldKey,
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            iconTheme: theme.primaryIconTheme,
            centerTitle: true,
            title: Text("Change Baani Order"),
            titleTextStyle: theme.appBarTheme.titleTextStyle,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: () {
                  vm.onOrderResetAction(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  vm.onOrderSaveAction(context);
                },
              ),
            ],
          ),
          body: Scrollbar(
            child: ReorderableListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              onReorderItem: (int oldIndex, int newIndex) {
                if (newIndex > oldIndex) newIndex -= 1;
                final element = PathTileData.items.removeAt(oldIndex);
                PathTileData.items.insert(newIndex, element);
                printInfoMessage(
                  "Baani Order Changed To: ${PathTileData.items}",
                );
                vm.onOrderChangeAction(context);
              },
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
  final void Function(BuildContext) onOrderSaveAction;
  final void Function(BuildContext) onOrderChangeAction;
  final void Function(BuildContext) onOrderResetAction;

  _ViewModel({
    required this.onOrderSaveAction,
    required this.onOrderChangeAction,
    required this.onOrderResetAction,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onOrderSaveAction: (BuildContext ctx) {
        List<dynamic> itemIds =
            PathTileData.items.map((item) => item.id).toList();
        StoreProvider.of<AppState>(ctx).dispatch(BaaniOrderSaveAction(itemIds));
        AppNavigator.goBack(ctx);
      },
      onOrderChangeAction: (BuildContext ctx) {
        StoreProvider.of<AppState>(ctx).dispatch(BaaniOrderChangeAction());
      },
      onOrderResetAction: (BuildContext ctx) {
        // Reorder based on original order IDs
        final idToItem = {for (var item in PathTileData.items) item.id: item};
        List<PathTile> originalOrder =
            PathTileData.defaultOrderIds.map((id) => idToItem[id]!).toList();
        PathTileData.items = originalOrder;
        StoreProvider.of<AppState>(ctx).dispatch(BaaniOrderResetAction());
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
