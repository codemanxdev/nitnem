import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/state/appstate.dart';
import 'package:redux/redux.dart';

enum StatsRange { week, month, year }

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  StatsRange _selectedRange = StatsRange.week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            title: const Text('Activity'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGoalAndStreak(context, vm),
                  const SizedBox(height: 24),
                  _buildSummaryCards(context, vm),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Activity',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      _buildRangeSelector(theme),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildChart(context, vm),
                  const SizedBox(height: 32),
                  const Text(
                    'Recent Sessions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildRecentSessions(context, vm),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRangeSelector(ThemeData theme) {
    return SegmentedButton<StatsRange>(
      segments: const [
        ButtonSegment(value: StatsRange.week, label: Text('W')),
        ButtonSegment(value: StatsRange.month, label: Text('M')),
        ButtonSegment(value: StatsRange.year, label: Text('Y')),
      ],
      selected: {_selectedRange},
      onSelectionChanged: (Set<StatsRange> newSelection) {
        setState(() {
          _selectedRange = newSelection.first;
        });
      },
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        selectedBackgroundColor: theme.primaryColor,
        selectedForegroundColor: Colors.white,
      ),
    );
  }

  Widget _buildGoalAndStreak(BuildContext context, _ViewModel vm) {
    final theme = Theme.of(context);
    final todayMinutes = vm.todayDurationSeconds / 60.0;
    final progress = (todayMinutes / vm.dailyGoalMinutes).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Goal Progress
          Column(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: theme.primaryColor.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                    ),
                    Center(
                      child: Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text('Today\'s Goal', style: TextStyle(fontSize: 12)),
              Text(
                '${todayMinutes.toInt()} / ${vm.dailyGoalMinutes}m',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // Streak
          Column(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 4),
              Text(
                '${vm.currentStreak}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              const Text('Day Streak', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context, _ViewModel vm) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Total Time',
            value: '${(vm.totalDurationSeconds / 60).toStringAsFixed(1)}m',
            icon: Icons.timer,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Sessions',
            value: '${vm.sessions.length}',
            icon: Icons.history,
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context, _ViewModel vm) {
    final theme = Theme.of(context);
    final List<FlSpot> spots = [];
    final List<String> labels = [];

    final now = DateTime.now();

    if (_selectedRange == StatsRange.week) {
      for (int i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        final daySessions = vm.sessions.where((s) =>
            s.startTime.day == date.day &&
            s.startTime.month == date.month &&
            s.startTime.year == date.year);
        final totalMin = daySessions.fold(0, (sum, s) => sum + s.durationSeconds) / 60.0;
        spots.add(FlSpot((6 - i).toDouble(), totalMin));
        labels.add(DateFormat('E').format(date));
      }
    } else if (_selectedRange == StatsRange.month) {
      // Last 30 days grouped into 6 spots (5 days each) for clarity
      for (int i = 5; i >= 0; i--) {
        final groupEnd = now.subtract(Duration(days: i * 5));
        final groupStart = groupEnd.subtract(const Duration(days: 4));
        final groupSessions = vm.sessions.where((s) =>
            s.startTime.isAfter(groupStart.subtract(const Duration(seconds: 1))) &&
            s.startTime.isBefore(groupEnd.add(const Duration(days: 1))));
        final totalMin = groupSessions.fold(0, (sum, s) => sum + s.durationSeconds) / 60.0;
        spots.add(FlSpot((5 - i).toDouble(), totalMin));
        labels.add('${DateFormat('d/M').format(groupStart)}');
      }
    } else {
      // Last 12 months
      for (int i = 11; i >= 0; i--) {
        final date = DateTime(now.year, now.month - i, 1);
        final monthSessions = vm.sessions.where((s) =>
            s.startTime.month == date.month && s.startTime.year == date.year);
        final totalMin = monthSessions.fold(0, (sum, s) => sum + s.durationSeconds) / 60.0;
        spots.add(FlSpot((11 - i).toDouble(), totalMin));
        labels.add(DateFormat('MMM').format(date));
      }
    }

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= labels.length || value.toInt() < 0) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      labels[value.toInt()],
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: theme.primaryColor,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: theme.primaryColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSessions(BuildContext context, _ViewModel vm) {
    final theme = Theme.of(context);
    if (vm.sessions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No sessions recorded yet'),
        ),
      );
    }

    final reversedSessions = vm.sessions.reversed.toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reversedSessions.length > 5 ? 5 : reversedSessions.length,
      itemBuilder: (context, index) {
        final session = reversedSessions[index];
        return ListTile(
          leading: Icon(Icons.menu_book, color: theme.primaryColor),
          title: Text(session.pathTitle),
          subtitle: Text(DateFormat('MMM d, h:mm a').format(session.startTime)),
          trailing: Text('${(session.durationSeconds / 60).toStringAsFixed(1)} min'),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  final List<ReadingSession> sessions;
  final int totalDurationSeconds;
  final int todayDurationSeconds;
  final int currentStreak;
  final int dailyGoalMinutes;

  _ViewModel({
    required this.sessions,
    required this.totalDurationSeconds,
    required this.todayDurationSeconds,
    required this.currentStreak,
    required this.dailyGoalMinutes,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final sessions = store.state.options.readingSessions;
    final totalDuration = sessions.fold(0, (sum, s) => sum + s.durationSeconds);
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final todayDuration = sessions
        .where((s) => 
            s.startTime.year == today.year && 
            s.startTime.month == today.month && 
            s.startTime.day == today.day)
        .fold(0, (sum, s) => sum + s.durationSeconds);

    return _ViewModel(
      sessions: sessions,
      totalDurationSeconds: totalDuration,
      todayDurationSeconds: todayDuration,
      currentStreak: _calculateStreak(sessions),
      dailyGoalMinutes: store.state.options.dailyGoalMinutes,
    );
  }

  static int _calculateStreak(List<ReadingSession> sessions) {
    if (sessions.isEmpty) return 0;

    final readDates = sessions
        .map((s) => DateTime(s.startTime.year, s.startTime.month, s.startTime.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (readDates.isEmpty || (!readDates.first.isAtSameMomentAs(today) && !readDates.first.isAtSameMomentAs(yesterday))) {
      return 0;
    }

    int streak = 0;
    DateTime checkDate = readDates.first;

    for (final date in readDates) {
      if (date.isAtSameMomentAs(checkDate)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }
}
