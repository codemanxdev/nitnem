import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/models/language.dart';
import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/pages/options.dart';
import 'package:nitnem/providers/path_data_provider.dart';
import 'package:nitnem/providers/reader_provider.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:nitnem/themes/themedata.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  ReaderScreen({required Key key}) : super(key: key);

  @override
  _MyReaderPageState createState() => _MyReaderPageState();
}

class _MyReaderPageState extends ConsumerState<ReaderScreen>
    with WidgetsBindingObserver {
  final Battery _battery = Battery();
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);
  static final GlobalKey _optionsKey = GlobalKey();
  static final GlobalKey<ScaffoldState> _readerScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  //Ephemeral State
  String _batteryLevel = '';
  String _currentTime = '';
  bool _topButtonVisible = false;
  Timer? _batteryTimer;
  Timer? _scrollPosTimer;

  // Session Tracking
  int _activeSeconds = 0;
  DateTime? _lastResumeTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastResumeTime = DateTime.now();
    _startBatteryUpdateTimer();
    _updateBatteryLevel();
    _updateCurrentTime();
    _startScrollPosUpdateTimer();
    _controller.addListener(() {
      printInfoMessage('[SCROLL] offset=${_controller.offset}');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _saveSession(); // Save current segment before app goes away
    } else if (state == AppLifecycleState.resumed) {
      _lastResumeTime = DateTime.now();
    }
  }

  void _updateActiveSeconds() {
    if (_lastResumeTime != null) {
      _activeSeconds += DateTime.now().difference(_lastResumeTime!).inSeconds;
      _lastResumeTime = null;
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _startBatteryUpdateTimer() {
    _batteryTimer = Timer.periodic(
      Duration(seconds: AppConstants.STATUS_TIME_UPDATE_INTERVAL_SECONDS),
      (Timer t) => _updateCurrentTime(),
    );
  }

  void _startScrollPosUpdateTimer() {
    _scrollPosTimer = Timer(Duration(milliseconds: 500), () {
      _navigateToScrollPositionOnLoad();
    });
  }

  void _updateBatteryLevel() {
    _battery.batteryLevel.then((level) {
      setState(() {
        _batteryLevel = level.toString();
      });
    });
  }

  void _updateCurrentTime() {
    printInfoMessage('[TIMER TICK] rebuilding ReaderScreen, controller.offset=${_controller.hasClients ? _controller.offset : "n/a"}');
    DateTime dateTime = DateTime.now();
    final timeFormatter = DateFormat('HH:mm a');
    final formattedTime = timeFormatter.format(dateTime);

    setState(() {
      _currentTime = formattedTime.toString();
    });
  }

  void _updateTopButtonVisibility() {
    if (_controller.hasClients && _controller.position.maxScrollExtent > 0.0) {
      setState(() {
        _topButtonVisible =
            _controller.offset == _controller.position.maxScrollExtent;
      });
    }
  }

  String _calculateScrollPerc(double offset, double maxoffset) {
    final double scrollPerc =
        (offset != 0.0) ? (offset / maxoffset) * 100 : 0.0;
    return scrollPerc.toStringAsFixed(2);
  }

  _navigateToScrollPositionOnLoad() {
    final readerState = ref.read(readerProvider);
    final settings = ref.read(settingsProvider).value;

    if (settings != null && settings.saveScrollPosition) {
      final double loadedScrollOffset =
          settings.scrollOffset[readerState.pathId.toString()]?.scrollOffset ??
          0.0;
      _controller.animateTo(
        loadedScrollOffset,
        duration: new Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    _updateScrollPositionInStatusBar();
  }

  _updateScrollPositionInStatusBar() {
    final readerState = ref.read(readerProvider);
    //dispatch action to update scroll position indicator
    final double maxOffset =
        _controller.hasClients ? _controller.position.maxScrollExtent : 0.0;
    final double offset = _controller.hasClients ? _controller.offset : 0.0;

    // Use microtask to avoid modifying providers during build/layout
    Future.microtask(() {
      if (!mounted) return;
      ref.read(readerProvider.notifier).updateOffsets(offset, maxOffset);

      final settings = ref.read(settingsProvider).value;
      if (settings != null) {
        ref.read(settingsProvider.notifier).updateScrollOffset(
              ScrollInfo(
                  id: readerState.pathId,
                  scrollOffset: offset,
                  maxOffset: maxOffset),
            );
      }
    });
  }

  _onEndScroll(ScrollMetrics metrics) {
    _updateTopButtonVisibility();
    _updateScrollPositionInStatusBar();
  }

  void _saveSession() {
    _updateActiveSeconds();

    if (_activeSeconds > 5) {
      final readerState = ref.read(readerProvider);
      final settings = ref.read(settingsProvider).value;

      if (settings != null) {
        final session = ReadingSession(
          pathId: readerState.pathId,
          pathTitle: readerState.pathTitle,
          startTime: DateTime.now().subtract(Duration(seconds: _activeSeconds)),
          endTime: DateTime.now(),
          durationSeconds: _activeSeconds,
        );

        final List<ReadingSession> newSessions =
            List<ReadingSession>.from(settings.readingSessions)..add(session);
        if (newSessions.length > 1000) newSessions.removeAt(0);

        // Streak calculation logic moved from reducer to provider method
        final today = DateTime.now();
        final normalizedToday = DateTime(today.year, today.month, today.day);
        final lastRead = settings.lastReadDate != null
            ? DateTime(
                settings.lastReadDate!.year,
                settings.lastReadDate!.month,
                settings.lastReadDate!.day,
              )
            : null;

        int newStreak = settings.currentStreak;
        if (lastRead == null) {
          newStreak = 1;
        } else {
          final difference = normalizedToday.difference(lastRead).inDays;
          if (difference == 1) {
            newStreak += 1;
          } else if (difference > 1) {
            newStreak = 1;
          }
        }

        final updatedOptions = settings.copyWith(
          readingSessions: newSessions,
          totalReadingDuration:
              settings.totalReadingDuration + session.durationSeconds,
          totalSessionsCount: settings.totalSessionsCount + 1,
          currentStreak: newStreak,
          lastReadDate: today,
        );

        ref.read(settingsProvider.notifier).saveReadingSession(updatedOptions);
      }
    }
    _activeSeconds = 0;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // Use select to watch ONLY what we need for the UI.
    // Do NOT watch the whole settingsProvider, otherwise scroll updates will trigger a rebuild!
    final themeName = ref.watch(settingsProvider.select((s) => s.value?.themeName ?? 'Default'));
    final isBold = ref.watch(settingsProvider.select((s) => s.value?.bold ?? false));
    final showStatus = ref.watch(settingsProvider.select((s) => s.value?.showStatus ?? false));
    final textScaleValue = ref.watch(settingsProvider.select((s) => s.value?.textScaleValue ?? 1.0));
    final languageName = ref.watch(settingsProvider.select((s) => s.value?.languageName ?? 'English'));

    final readerState = ref.watch(readerProvider);
    final pathDataAsync = ref.watch(pathDataProvider);

    printInfoMessage('[BUILD] ReaderScreen');
    printInfoMessage('[STATE] Battery: $_batteryLevel, Time: $_currentTime');

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          _saveSession();
          ref.read(readerProvider.notifier).setReaderOptionsVisible(false);
        }
      },
      child: Scaffold(
        key: _readerScreenScaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              colorFilter: new ColorFilter.mode(
                Colors.amber.withValues(
                  alpha: AppConstants.READERTHEME_BACK_OPACITY,
                ),
                BlendMode.dstATop,
              ),
              image: new AssetImage(
                "assets/themes/$themeName.jpg",
              ),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: Scrollbar(
            child: NotificationListener<ScrollNotification>(
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: isDark ? kFlutterBlue : theme.primaryColor,
                    iconTheme: theme.primaryIconTheme,
                    actions: <Widget>[
                      IconButton(
                        key: const Key('reader_options_button'),
                        icon: Icon(
                          Icons.tune,
                          color: theme.primaryIconTheme.color ?? Colors.white,
                        ),
                        onPressed: () {
                          ref.read(readerProvider.notifier).toggleReaderOptions();
                        },
                      ),
                    ],
                    pinned: false,
                    snap: false,
                    floating: true,
                    expandedHeight: readerState.showReaderOptions
                        ? AppConstants.EXPANDED_APP_BAR
                        : kToolbarHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        (readerState.showReaderOptions)
                            ? AppConstants.EMPTY_STRING
                            : readerState.pathTitle,
                        style: theme.appBarTheme.titleTextStyle,
                      ),
                      background: readerState.showReaderOptions
                          ? OptionsPage(
                              readerMode: true,
                              key: _optionsKey,
                            )
                          : Container(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Scrollbar(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          AppConstants.READER_PADDING,
                        ),
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            textScaler: TextScaler.linear(
                              textScaleValue,
                            ),
                          ),
                          child: pathDataAsync.when(
                            data: (pathData) => Text(
                              pathData,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                height: 2.0,
                                fontFamily: getLanguageMenuItemValueByName(
                                  languageName,
                                ).fontName,
                                fontSize: getLanguageMenuItemValueByName(
                                  languageName,
                                ).fontSize,
                                fontWeight: isBold
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (err, stack) => const Center(
                              child: Icon(Icons.error_outline, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  _onEndScroll(scrollNotification.metrics);
                }
                return false;
              },
            ),
          ),
        ),
        bottomNavigationBar: showStatus
            ? Container(
                color: Colors.black, // Background for system navigation bar area
                child: MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: SafeArea(
                    top: false,
                    child: new Container(
                      height: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.all(
                          AppConstants.STATUSBAR_PADDING,
                        ),
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: new Row(
                                children: <Widget>[
                                  (defaultTargetPlatform ==
                                          TargetPlatform.android)
                                      ? Icon(Icons.battery_std, size: 12, color: theme.iconTheme.color)
                                      : Container(),
                                  Text(
                                    _batteryLevel + "%",
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      fontFamily:
                                          AppConstants.STATUSBAR_FONT_FAMILY,
                                      fontSize: AppConstants.STATUSBAR_FONT_SIZE,
                                      fontWeight: FontWeight.normal,
                                      color: theme.textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _currentTime,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontFamily: AppConstants.STATUSBAR_FONT_FAMILY,
                                  fontSize: AppConstants.STATUSBAR_FONT_SIZE,
                                  fontWeight: FontWeight.normal,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                readerState.pathTitle,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontFamily: AppConstants.STATUSBAR_FONT_FAMILY,
                                  fontSize: AppConstants.STATUSBAR_FONT_SIZE,
                                  fontWeight: FontWeight.normal,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: (defaultTargetPlatform ==
                                      TargetPlatform.android)
                                  ? 1
                                  : 2,
                              child: Text(
                                _calculateScrollPerc(
                                      readerState.scrollOffset,
                                      readerState.maxOffset,
                                    ) +
                                    "%",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontFamily: AppConstants.STATUSBAR_FONT_FAMILY,
                                  fontSize: AppConstants.STATUSBAR_FONT_SIZE,
                                  fontWeight: FontWeight.normal,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              )
            : null,
        floatingActionButton: Visibility(
          visible: _topButtonVisible,
          child: SizedBox(
            width: 50,
            height: 50,
            child: FloatingActionButton(
              onPressed: () {
                _controller.animateTo(
                  0.0,
                  duration: new Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              child: Icon(Icons.vertical_align_top_rounded),
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  @protected
  @override
  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _batteryTimer?.cancel();
    _scrollPosTimer?.cancel();
    super.dispose();
  }
}
