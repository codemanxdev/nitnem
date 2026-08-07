import 'package:nitnem/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final totalDurationReducer = combineReducers<int>([
  TypedReducer<int, SaveReadingSessionAction>(
    (state, action) => state + action.session.durationSeconds,
  ),
]);

final totalSessionsCountReducer = combineReducers<int>([
  TypedReducer<int, SaveReadingSessionAction>((state, action) => state + 1),
]);
