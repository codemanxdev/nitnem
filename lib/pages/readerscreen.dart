import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/models/language.dart';
import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/pages/options.dart';
import 'package:nitnem/providers/path_data_provider.dart';
import 'package:nitnem/providers/reader_provider.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:nitnem/providers/system_providers.dart';
import 'package:nitnem/themes/themedata.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  ReaderScreen({required Key key}) : super(key: key);

  @override
  _MyReaderPageState createState() => _MyReaderPageState();
}

class _MyReaderPageState extends ConsumerState<ReaderScreen>
    with WidgetsBindingObserver {
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);
  static final GlobalKey _optionsKey = GlobalKey();
  static final GlobalKey<ScaffoldState> _readerScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  bool _topButtonVisible = false;
  Timer? _scrollPosTimer;

  // Session Tracking
  int _activeSeconds = 0;
  DateTime? _lastResumeTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastResumeTime = DateTime.now();
    _startScrollPosUpdateTimer();
    _controller.addListener(() {
      _updateTopButtonVisibility();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _saveSession();
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

  void _startScrollPosUpdateTimer() {
    _scrollPosTimer = Timer(Duration(milliseconds: 500), () {
      _navigateToScrollPositionOnLoad();
    });
  }

  void _updateTopButtonVisibility() {
    if (_controller.hasClients && _controller.position.maxScrollExtent > 0.0) {
      final bool shouldBeVisible =
          _controller.offset >= _controller.position.maxScrollExtent;
      if (_topButtonVisible != shouldBeVisible) {
        setState(() {
          _topButtonVisible = shouldBeVisible;
        });
      }
    }
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
    final double maxOffset =
        _controller.hasClients ? _controller.position.maxScrollExtent : 0.0;
    final double offset = _controller.hasClients ? _controller.offset : 0.0;

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
    _updateScrollPositionInStatusBar();
  }

  void _saveSession() {
    _updateActiveSeconds();

    if (_activeSeconds > 5) {
      final readerState = ref.read(readerProvider);
      ref.read(settingsProvider.notifier).recordReadingSession(
            pathId: readerState.pathId,
            pathTitle: readerState.pathTitle,
            durationSeconds: _activeSeconds,
          );
    }
    _activeSeconds = 0;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final themeName = ref.watch(
        settingsProvider.select((s) => s.value?.themeName ?? 'Default'));
    final isBold =
        ref.watch(settingsProvider.select((s) => s.value?.bold ?? false));
    final showStatus =
        ref.watch(settingsProvider.select((s) => s.value?.showStatus ?? false));
    final textScaleValue = ref.watch(
        settingsProvider.select((s) => s.value?.textScaleValue ?? 1.0));
    final languageName = ref.watch(
        settingsProvider.select((s) => s.value?.languageName ?? 'English'));

    final pathTitle = ref.watch(readerProvider.select((s) => s.pathTitle));
    final showReaderOptions =
        ref.watch(readerProvider.select((s) => s.showReaderOptions));

    final pathDataAsync = ref.watch(pathDataProvider);

    printInfoMessage('[BUILD] ReaderScreen');

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
                          ref
                              .read(readerProvider.notifier)
                              .toggleReaderOptions();
                        },
                      ),
                    ],
                    pinned: false,
                    snap: false,
                    floating: true,
                    expandedHeight: showReaderOptions
                        ? AppConstants.EXPANDED_APP_BAR
                        : kToolbarHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        (showReaderOptions)
                            ? AppConstants.EMPTY_STRING
                            : pathTitle,
                        style: theme.appBarTheme.titleTextStyle,
                      ),
                      background: showReaderOptions
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
                              child:
                                  Icon(Icons.error_outline, color: Colors.grey),
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
        bottomNavigationBar: showStatus ? const _ReaderBottomBar() : null,
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
    _scrollPosTimer?.cancel();
    super.dispose();
  }
}

class _ReaderBottomBar extends ConsumerWidget {
  const _ReaderBottomBar();

  String _calculateScrollPerc(double offset, double maxoffset) {
    final double scrollPerc =
        (offset != 0.0) ? (offset / maxoffset) * 100 : 0.0;
    return scrollPerc.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pathTitle = ref.watch(readerProvider.select((s) => s.pathTitle));
    final scrollOffset = ref.watch(readerProvider.select((s) => s.scrollOffset));
    final maxOffset = ref.watch(readerProvider.select((s) => s.maxOffset));

    final batteryLevelAsync = ref.watch(batteryLevelProvider);
    final currentTimeAsync = ref.watch(currentTimeProvider);

    return Container(
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
                        (defaultTargetPlatform == TargetPlatform.android)
                            ? Icon(Icons.battery_std,
                                size: 12, color: theme.iconTheme.color)
                            : Container(),
                        Text(
                          "${batteryLevelAsync.value ?? '--'}%",
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            fontFamily: AppConstants.STATUSBAR_FONT_FAMILY,
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
                      currentTimeAsync.value ?? '--:--',
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
                      pathTitle,
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
                    flex: (defaultTargetPlatform == TargetPlatform.android)
                        ? 1
                        : 2,
                    child: Text(
                      _calculateScrollPerc(
                            scrollOffset,
                            maxOffset,
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
    );
  }
}
