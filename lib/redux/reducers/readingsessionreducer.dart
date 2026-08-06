import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final readingSessionReducer = combineReducers<List<ReadingSession>>([
  TypedReducer<List<ReadingSession>, SaveReadingSessionAction>(_saveSession),
]);

List<ReadingSession> _saveSession(
  List<ReadingSession> sessions,
  SaveReadingSessionAction action,
) {
  // Add new session and keep only last 100 sessions to avoid bloated storage
  final newList = List<ReadingSession>.from(sessions)..add(action.session);
  if (newList.length > 100) {
    newList.removeAt(0);
  }
  return newList;
}
