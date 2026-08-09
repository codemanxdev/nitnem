import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final scrollPercReducer = combineReducers<Map<String, ScrollInfo>>([
  TypedReducer<Map<String, ScrollInfo>, UpdateStatusScrollPercentageAction>(_activeScrollPercReducer),
]);

Map<String, ScrollInfo> _activeScrollPercReducer(Map<String, ScrollInfo> info, UpdateStatusScrollPercentageAction action) {
  // Return a new map to ensure immutability
  return Map<String, ScrollInfo>.from(info)
    ..update(action.scrollInfo.id.toString(), (ScrollInfo val) => action.scrollInfo);
}