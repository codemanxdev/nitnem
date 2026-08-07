import 'package:nitnem/redux/actions/actions.dart';
import 'package:nitnem/state/appoptions.dart';

int currentStreakReducer(AppOptions options, dynamic action) {
  if (action is! SaveReadingSessionAction) return options.currentStreak;

  final today = DateTime(
    action.timestamp.year,
    action.timestamp.month,
    action.timestamp.day,
  );

  final lastRead = options.lastReadDate != null
      ? DateTime(
        options.lastReadDate!.year,
        options.lastReadDate!.month,
        options.lastReadDate!.day,
      )
      : null;

  if (lastRead == null) {
    return 1;
  }

  final difference = today.difference(lastRead).inDays;

  if (difference == 1) {
    return options.currentStreak + 1;
  } else if (difference > 1) {
    return 1;
  } else {
    // difference == 0 (already read today), keep streak
    return options.currentStreak;
  }
}

DateTime? lastReadDateReducer(DateTime? state, dynamic action) {
  if (action is SaveReadingSessionAction) {
    return action.timestamp;
  }
  return state;
}
