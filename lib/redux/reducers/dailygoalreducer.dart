import 'package:nitnem/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final dailyGoalReducer = combineReducers<int>([
  TypedReducer<int, ChangeDailyGoalAction>(_changeGoal),
]);

int _changeGoal(int state, ChangeDailyGoalAction action) {
  return action.minutes;
}
