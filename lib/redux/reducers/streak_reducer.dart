import 'package:nitnem/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final currentStreakReducer = combineReducers<int>([
  TypedReducer<int, SaveReadingSessionAction>(_updateStreak),
]);

int _updateStreak(int state, SaveReadingSessionAction action) {
  // We'll calculate the value in middleware and just pass it if we want,
  // but here we can also do it. However, we need the lastReadDate.
  // For simplicity in this Redux setup, let's calculate in middleware and update state.
  return state; // Placeholder, see middleware
}

final lastReadDateReducer = combineReducers<DateTime?>([
  TypedReducer<DateTime?, SaveReadingSessionAction>((state, action) => DateTime.now()),
]);
